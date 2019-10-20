pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;


contract ToDo {

  constructor() public {
      lastTaskId = 0;
  }

  struct Task {
    uint id;
    uint date;
    string content;
    string author;
    bool done;
  }


  uint public lastTaskId;
  uint[] taskIds;
  mapping(uint => Task) public tasks;

  event TaskCreated(uint,uint,string,string,bool);  


  function createTask(string memory _content, string memory _author) public {
     lastTaskId++;
     tasks[lastTaskId] = Task(lastTaskId, now,_content, _author,false);
     taskIds.push(lastTaskId);
     emit TaskCreated(lastTaskId, now , _content, _author, false);
     
     
  }

  function getTask(uint id) taskExists(id) public view returns(uint,uint,string memory,string memory,bool){
       if(tasks[id].id == 0)
       revert();

       return (
         id, 
         tasks[id].date,
         tasks[id].content,
         tasks[id].author,
         tasks[id].done
       );
  }

  function getTaskIds() public view returns(uint[] memory){
     return taskIds;
  }

   
  modifier taskExists(uint id){
     if(tasks[id].id == 0)
       revert();
  _;  
  }
}
