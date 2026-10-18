package dragontalker.item
{
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class DragonTalkPassitiveSkillPane extends Sprite
   {
      
      private var _tag:DragonTalkerTag;
      
      private var _vbox:VBox;
      
      public function DragonTalkPassitiveSkillPane()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _tag = new DragonTalkerTag(6);
         _vbox = new VBox();
         addChild(_tag);
         addChild(_vbox);
      }
      
      public function refreshViewByList(param1:Array) : void
      {
         var _loc2_:Array = null;
         var _loc3_:DragonTalkerSkillGroupItem = null;
         var _loc4_:int = 0;
         _vbox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = param1[_loc4_];
            if(_loc2_ && _loc2_.length > 0)
            {
               _loc3_ = new DragonTalkerSkillGroupItem();
               _loc3_.creatItems(_loc2_);
               _vbox.addChild(_loc3_);
            }
            _loc4_++;
         }
         _vbox.commitChanges();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_tag);
         _tag = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

