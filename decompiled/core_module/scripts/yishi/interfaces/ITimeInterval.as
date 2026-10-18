package yishi.interfaces
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.DisplayObject;
   
   public interface ITimeInterval extends Disposeable
   {
      
      function get currentTime() : Number;
      
      function addView(param1:DisplayObject) : void;
      
      function getViews() : Array;
      
      function canExec(param1:int) : Boolean;
      
      function isFinished() : Boolean;
      
      function execute() : void;
      
      function quicken(param1:int) : void;
      
      function cancel() : void;
      
      function finished() : void;
   }
}

