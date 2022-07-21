public with sharing class DataStructuresAlgorithms {

    public static Set<Integer> getUniqueValuesInList(List<Integer> myList) {
        return new Set<Integer>(myList);
    }

    public static List<Integer> getUniqueValuesInListSecondOption(List<Integer> myList) {
        myList.sort();
        List<Integer> result = new List<Integer>();

        for (Integer i = 0; i < myList.size(); i++) {
            if (!result.contains(myList.get(i))) {
                result.add(myList.get(i));
            }
        }
        return result;
    }

    public static Contact getContactByName(String name) {
        List<Contact> contact = (List<Contact>) [SELECT Id, Name, Phone, Email
                                                 FROM Contact WHERE FirstName =: name];
        return contact[0];
    }

    public static Opportunity getOppWithTheBiggestAmount() {
        List<Opportunity> opportunity = (List<Opportunity>) [SELECT Id, Name, Amount FROM Opportunity
                                                             ORDER BY Amount DESC LIMIT 1];
        return opportunity[0];
    }

    public static List<Integer> returnListOfNumbers(Integer myNumber) {
        Integer inputNumber = myNumber;
        List<Integer> myList = new List<Integer>();
        List<Integer> result = new List<Integer>();

        do {
            myList.add(Math.mod(inputNumber, 10));
            inputNumber /= 10;
        } while (inputNumber > 0);

        for (Integer i = myList.size() - 1; i >= 0; i--) {
            result.add(myList.get(i));
        }
        return result;
    }

    public static List<Integer> returnListOfNumbersSecondOption(Integer myNumber) {
        Integer lengthList = String.valueOf(Math.abs(myNumber)).length();
        Integer inputNumber = myNumber;
        Integer remainderDivision = 0;

        List<Integer> result = new List<Integer>(lengthList);

        for (Integer i = result.size()-1; i > -1; i--) {
            remainderDivision = Math.mod(inputNumber, 10);
            result.set(i, remainderDivision);
            inputNumber /= 10;
        }
        return result;
    }
}