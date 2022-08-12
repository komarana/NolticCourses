public with sharing class Queue {

    private List<Integer> listQueue = new List<Integer>();

    public void push(Integer itemToPush){
        listQueue.add(itemToPush);
    }

    public Integer pop(){
        if(listQueue.size() > 0){
            return listQueue.remove(0);
        }
        return null;
    }

    public Integer getLastElementQueue(){
        if(listQueue.size() > 0) {
            return listQueue.get(listQueue.size() - 1);
        }
        return null;
    }

    public Integer peek(){
        if(listQueue.size() > 0){
            return listQueue.get(0);
        }
        return null;
    }

    public Boolean isEmpty(){
        return listQueue.size() == 0;
    }

    public Integer size(){
        return listQueue.size();
    }

    public void clear(){
        listQueue.clear();
    }
}