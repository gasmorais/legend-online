package yishi.view.tips.goods
{
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.FashionManager;
   
   public class EquipRefreshTipItem extends Sprite implements Disposeable
   {
      
      private var _fashionDesc1:FashionAttItem;
      
      private var _fashionDesc2:FashionAttItem;
      
      private var _fashionDesc3:FashionAttItem;
      
      private var _fashionDesc4:FashionAttItem;
      
      private var _fashionDesc5:FashionAttItem;
      
      private var _fashionDesc6:FashionAttItem;
      
      private var _vbox:VBox;
      
      private var _isShowAdd:Boolean = false;
      
      public function EquipRefreshTipItem()
      {
         super();
         _vbox = new VBox();
         _fashionDesc1 = new FashionAttItem();
         _fashionDesc2 = new FashionAttItem();
         _fashionDesc3 = new FashionAttItem();
         _fashionDesc4 = new FashionAttItem();
         _fashionDesc5 = new FashionAttItem();
         _fashionDesc6 = new FashionAttItem();
         addChild(_vbox);
      }
      
      public function isShowAdd(param1:Boolean) : void
      {
         _isShowAdd = param1;
      }
      
      public function setData(param1:String) : void
      {
         var _loc5_:int = 0;
         if(param1 == "")
         {
            return;
         }
         var _loc2_:Array = param1.split("<br>");
         clear();
         var _loc4_:int = int(_loc2_.length);
         param1 = "";
         var _loc3_:Array = FashionManager.instance.fashionModel.getAllLevelAdd();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            param1 = _loc2_[_loc5_];
            if(_isShowAdd)
            {
               param1 += LanguageMgr.GetTranslation("fashion.refreshView.tips09",_loc3_[_loc5_]);
            }
            this["_fashionDesc" + (_loc5_ + 1)].setData(param1);
            _vbox.addChild(this["_fashionDesc" + (_loc5_ + 1)]);
            _loc5_++;
         }
      }
      
      private function clear() : void
      {
         while(_vbox.numChildren > 0)
         {
            _vbox.removeChild(_vbox.getChildAt(_vbox.numChildren - 1));
         }
      }
      
      public function dispose() : void
      {
         _fashionDesc1.dispose();
         _fashionDesc2.dispose();
         _fashionDesc3.dispose();
         _fashionDesc4.dispose();
         _fashionDesc5.dispose();
         _fashionDesc6.dispose();
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
      }
   }
}

