public with sharing class Fighter {

    public String name {get; private set;}
    public Integer health {get; private set;}
    public Integer damagePerAttack {get; private set;}

    public Fighter(String name, Integer health, Integer damagePerAttack) {
        this.name = name;
        this.health = health;
        this.damagePerAttack = damagePerAttack;
    }

    public static String gameStart(Fighter playerFirst, Fighter playerSecond) {

        Integer resultPlayerFirst = 0, resultPlayerSecond = 0;

        for (Integer i = playerFirst.health; i >= 0; i -= playerSecond.damagePerAttack){
            resultPlayerSecond ++;
        }
        for (Integer i = playerSecond.health; i >= 0; i -= playerFirst.damagePerAttack){
            resultPlayerFirst ++;
        }
        return (resultPlayerSecond >= resultPlayerFirst)?playerFirst.name:playerSecond.name;
    }
}