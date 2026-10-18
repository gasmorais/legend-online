package yishi.view.tips
{
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   
   public class GuildFbPreviewBuffTip extends BaseTip
   {
      
      private var _hbox:VBox;
      
      private var _itemList:Vector.<GuildFbOneBuffTip>;
      
      public function GuildFbPreviewBuffTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _hbox = new VBox();
         _itemList = new Vector.<GuildFbOneBuffTip>();
         addChild(_hbox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:int = 0;
         var _loc1_:GuildFbOneBuffTip = null;
         var _loc4_:int = 0;
         ObjectUtils.removeChildAllChildrenFromStage(_hbox);
         var _loc2_:Array = tipData as Array;
         if(_loc2_ != null)
         {
            _hbox.beginChanges();
            _loc3_ = int(_loc2_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(_loc4_ >= _itemList.length)
               {
                  _loc1_ = new GuildFbOneBuffTip();
                  _itemList.push(_loc1_);
               }
               else
               {
                  _loc1_ = _itemList[_loc4_];
               }
               _loc1_.tipData = _loc2_[_loc4_];
               _hbox.addChild(_loc1_);
               _loc4_++;
            }
            _hbox.commitChanges();
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         super.dispose();
         _itemList = null;
      }
   }
}

