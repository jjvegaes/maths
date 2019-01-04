import numpy as np


def entropy(observations):
    occurrences = np.bincount(observations)
    probability_mass = occurrences / np.sum(occurrences)
    entropies = -probability_mass * (1-probability_mass)
    return numpy.nansum(entropies)


def gini(observations):
    occurrences = np.bincount(observations)
    probability_mass = occurrences / np.sum(occurrences)
    return np.sum(probability_mass * (1-probability_mass))


class DecisionTreeClassifier:
    def __init__(self, atributes, criterion=entropy):
        self.criterion = criterion
        self.atributes = atributes
        self.root = {}

    @staticmethod
    def split(X: np.ndarray, y: np.ndarray, atributes, used, evaluate):
        n = y.size
        assert X.shape[0] == y.size

        best_classes = None
        best_subset_X = None
        best_subset_y = None
        best_G = np.inf
        best_atribute = None
        best_atribute_index = None

        if np.unique(y).size == 1:
            return {
                "terminated": True,
                "class": y[0]
            }

        for index, atribute in enumerate(atributes):
            if not used[atribute]:
                columns = X[:, index]
                classes, counts = np.unique(columns, return_counts=True)
                G = 0
                splits_X = []
                splits_y = []
                for c, count in zip(classes, counts):
                    subset = np.where(columns == c)
                    subset_y = y[subset]
                    splits_X.append(X[subset])
                    splits_y.append(subset_y)
                    G += count / n * evaluate(subset_y)
                if G < best_G:
                    best_G = G
                    best_classes = classes
                    best_subset_X = splits_X
                    best_subset_y = splits_y
                    best_atribute = atribute
                    best_atribute_index = index
        best_split = {}
        used[best_atribute] = True
        if best_classes is None:
            return {
                "terminated": True,
                "class": np.bincount(y).argmax()
            }
        else:
            for index, c in enumerate(best_classes):
                best_split[c] = DecisionTreeClassifier.split(
                    best_subset_X[index], best_subset_y[index], atributes, used, evaluate)
            used[best_atribute] = False
            return {
                "atribute": best_atribute,
                "atribute_index": best_atribute_index,
                "split": best_split,
                "terminated": False
            }

    def train(self, X: np.ndarray, y: np.ndarray):
        assert X.shape[0] == y.size

        self.root = DecisionTreeClassifier.split(
            X, y, self.atributes, dict((a, False) for a in self.atributes), evaluate=self.criterion)

    def predict(self, X):
        def classify(x):
            current = self.root
            while not current["terminated"]:
                atribute_index = current["atribute_index"]
                clazz = x[atribute_index]
                current = current["split"][clazz]
            else:
                return current["class"]

        return np.apply_along_axis(classify, 1, X)
