//defineFeature usages.

    public function initFeatures() : void {
        _saltrClient.defineFeature(SCROLL_COUNT_FOR_JELLY_CLEARING_OBJECTIVE,
                {scrollCountJelly:DEFAULT_LONG_LEVEL_ROW_SCROLL_COUNT}
        );
        _saltrClient.defineFeature(SCROLL_COUNT_FOR_DRAGON_DROPPING_OBJECTIVE,
                {scrollCount1Row:DEFAULT_LONG_LEVEL_ROW_SCROLL_COUNT, scrollCount2Row:DEFAULT_LONG_LEVEL_ROW_SCROLL_COUNT,scrollCount3Row:DEFAULT_LONG_LEVEL_ROW_SCROLL_COUNT}
        );
        _saltrClient.defineFeature(SCROLL_COUNT_FOR_OBSTACLE_CLEARING_OBJECTIVE,
                {scrollCountNoObstacle:DEFAULT_LONG_LEVEL_ROW_SCROLL_COUNT, scrollCountObstacleOnLastRow:DEFAULT_LONG_LEVEL_ROW_SCROLL_COUNT}
        );
        _saltrClient.defineFeature(GENERATED_LINE_BOMB,
                {minRangeLimitForLineBombGeneration:DEFAULT_MIN_CUBES_COUNT_FOR_LINE_BOMB_GENERATION, maxRangeLimitForLineBombGeneration:DEFAULT_MAX_CUBES_COUNT_FOR_LINE_BOMB_GENERATION}
        );
        _saltrClient.defineFeature(GENERATED_RADIAL_BOMB,
                {minRangeLimitForRadialBombGeneration:DEFAULT_MIN_CUBES_COUNT_FOR_RADIAL_BOMB_GENERATION, maxRangeLimitForRadialBombGeneration:DEFAULT_MAX_CUBES_COUNT_FOR_RADIAL_BOMB_GENERATION}
        );
        _saltrClient.defineFeature(GENERATED_COLORLESS_BOMB,
                {minRangeLimitForColorlessBombGeneration:DEFAULT_MIN_CUBES_COUNT_FOR_COLORLESS_BOMB_GENERATION, maxRangeLimitForColorlessBombGeneration:DEFAULT_MAX_CUBES_COUNT_FOR_COLORLESS_BOMB_GENERATION}
        );

        _saltrClient.defineFeature(InGameBoostManager.CHAMELEON_BOMB_TOKEN, {price: "100", order: "1", packSize: 3});
        _saltrClient.defineFeature(InGameBoostManager.HAMMER_TOKEN, {price: "120", order: "2", packSize: 3});
        _saltrClient.defineFeature(InGameBoostManager.EXTRA_MOVES_TOKEN, {price: "140", order: "3", packSize: 1});
        _saltrClient.defineFeature(InGameBoostManager.VERTICAL_LINE_BOMB_TOKEN, {price: "160", order: "4", packSize: 3});
        _saltrClient.defineFeature(InGameBoostManager.VIRUS_EATER_TOKEN, {price: "180", order: "5", packSize: 1});

        _saltrClient.defineFeature(PreGameBoostManager.COLUMN_CLEARER_TOKEN, {price: "200", order: "1", packSize: 3});
        _saltrClient.defineFeature(PreGameBoostManager.COLOR_REMOVER_TOKEN, {price: "220", order: "2", packSize: 3});
        _saltrClient.defineFeature(PreGameBoostManager.COLOR_REMOVER_TOKEN, {price: "220", order: "2", packSize: 3});
        _saltrClient.defineFeature(PreGameBoostManager.RADIAL_BOMB_MOVES_TOKEN, {price: "260", order: "4", packSize: 3});
    }


//getAppData usages

    public function connect():void {
        var saltrClient : Saltr = MobileSaltrBuilder.create(ANY_SALT_INSTANCE_KEY);
        saltrClient.initDevice(Agent.device.udid, Device.IPHONE_5);
        saltrClient.initPartner("any fb id", "FB");
        saltrClient.getAppData(getAppDataSuccessHandler, getAppDataFailHandler);
    }    