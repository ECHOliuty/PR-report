def calcInfoGainForSeries(dataSet, i, baseEntropy):
    """
    计算连续值的信息增益
    :param dataSet:整个数据集
    :param i: 对应的特征值下标
    :param baseEntropy: 基础信息熵
    :return: 返回一个信息增益值，和当前的划分点
    """

    # 记录最大的信息增益
    maxInfoGain = -100.0

    # 最好的划分点
    bestMid = -1

    # 得到数据集中所有的当前特征值列表
    featList = [example[i] for example in dataSet]

    # 得到分类列表
    classList = [example[-1] for example in dataSet]

    dictList = dict(zip(featList, classList))

    # 将其从小到大排序，按照连续值的大小排列
    sortedFeatList = sorted(dictList.items(), key=operator.itemgetter(0))
    # 计算连续值有多少个
    numberForFeatList = len(sortedFeatList)

    # 计算划分点，保留三位小数
    midFeatList = [round((sortedFeatList[i][0] + sortedFeatList[i+1][0])/2.0, 3)for i in range(numberForFeatList - 1)]

    # 计算出各个划分点信息增益
    for mid in midFeatList:
        # 将连续值划分为不大于当前划分点和大于当前划分点两部分
        eltDataSet, gtDataSet = splitDataSetForSeries(dataSet, i, mid)

        # 计算两部分的特征值熵和权重的乘积之和
        newEntropy = len(eltDataSet)/len(sortedFeatList)*entropy(eltDataSet) + len(gtDataSet)/len(sortedFeatList)*entropy(gtDataSet)

        # 计算出信息增益
        infoGain = baseEntropy - newEntropy
        print('当前划分值为：' + str(mid) + '，此时的信息增益为：' + str(infoGain))
        if infoGain > maxInfoGain:
            bestMid = mid
            maxInfoGain = infoGain
    print(maxInfoGain)
    print(bestMid)
    return maxInfoGain, bestMid
