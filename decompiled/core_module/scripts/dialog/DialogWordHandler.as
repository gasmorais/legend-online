package dialog
{
   import com.greensock.TweenMax;
   import com.greensock.text.SplitTextField;
   
   public class DialogWordHandler
   {
      
      private var _speakEnd:Function;
      
      private var _textfield:SplitTextField;
      
      private var _completed:Boolean = false;
      
      public function DialogWordHandler(param1:SplitTextField, param2:Function)
      {
         super();
         _textfield = param1;
         _speakEnd = param2;
      }
      
      public function start() : void
      {
         TweenMax.allFrom(_textfield.textFields,0.25,{"alpha":0},0.1,speakComplete);
      }
      
      public function canStop() : Boolean
      {
         if(_textfield && _textfield.parent && !_completed)
         {
            TweenMax.killChildTweensOf(_textfield.parent,true);
            speakComplete();
            return true;
         }
         return false;
      }
      
      private function speakComplete() : void
      {
         if(!_completed)
         {
            if(_speakEnd != null)
            {
               _speakEnd();
            }
            _completed = true;
            _textfield = null;
         }
      }
      
      public function dispose() : void
      {
      }
   }
}

