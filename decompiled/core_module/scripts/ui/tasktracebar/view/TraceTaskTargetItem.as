package ui.tasktracebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   
   public class TraceTaskTargetItem extends Sprite implements Disposeable
   {
      
      private var _describe:FilterFrameText;
      
      private var _format:TextFormat = ComponentFactory.Instance.model.getSet("taskTrace.ItemProgressTxt_t");
      
      public function TraceTaskTargetItem()
      {
         super();
         init();
      }
      
      public function set describeWith(param1:int) : void
      {
         if(_describe)
         {
            _describe.width = param1;
         }
         this.width = param1;
      }
      
      private function init() : void
      {
         _describe = ComponentFactory.Instance.creatComponentByStylename("taskTrace.ItemDescribeTxt");
         addChild(_describe);
      }
      
      public function setCondition(param1:String) : void
      {
         _describe.text = param1;
      }
      
      public function setConditionProgress(param1:String) : void
      {
         var _loc2_:int = _describe.length;
         _describe.appendText(param1);
         _describe.setTextFormat(_format,_loc2_,_describe.length);
      }
      
      public function dispose() : void
      {
         if(_describe)
         {
            _describe.dispose();
         }
         _describe = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

