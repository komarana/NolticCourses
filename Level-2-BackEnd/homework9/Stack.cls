public with sharing class Stack {

    private List<Integer> listStack = new List<Integer>();

    public void push(Integer itemToPush){
        listStack.add(itemToPush);
    }

    public Integer pop(){
        if(listStack.size() > 0){
            return listStack.remove(listStack.size() - 1);
        }
        return null;
    }

    public Integer peek(){
        if(listStack.size() > 0){
            return listStack.get(listStack.size() - 1);
        }
        return null;
    }

    public Integer getFirstElementStack(){
        if(listStack.size() > 0) {
            return listStack.get(0);
        }
        return null;
    }

    public Boolean isEmpty(){
        return listStack.size() == 0;
    }

    public Integer size(){
        return listStack.size();
    }

    public void clear(){
        listStack.clear();
    }
}