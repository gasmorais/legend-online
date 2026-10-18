package ylex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.view.base.NumberBitmap;
   
   public class YLExpedtionDesItem extends Sprite
   {
      
      private var _title:NumberBitmap;
      
      private var _vbox:VBox;
      
      private var _list:Array = [];
      
      private var _type:int;
      
      private var _lv:int = -1;
      
      public function YLExpedtionDesItem(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      public function refreshView(param1:int, param2:String) : void
      {
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:FilterFrameText = null;
         var _loc6_:int = 0;
         if(_lv == param1)
         {
            return;
         }
         _lv = param1;
         _title.num = param1;
         if(param2 != null && param2 != "")
         {
            _loc3_ = param2.split("|");
            _loc5_ = int(_loc3_ ? _loc3_.length : 0);
            _vbox.removeAllChild();
            _vbox.beginChanges();
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = _list[_loc6_];
               if(_loc4_ == null)
               {
                  _loc4_ = ComponentFactory.Instance.creatComponentByStylename("ui.ylexdtion.ydVboxDesText");
                  _list[_loc6_] = _loc4_;
               }
               _loc4_.text = "" + _loc3_[_loc6_];
               _vbox.addChild(_loc4_);
               _loc6_++;
            }
            _vbox.commitChanges();
         }
      }
      
      private function initView() : void
      {
         _title = new NumberBitmap();
         _vbox = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.yddescVbox");
         addChild(_title);
         addChild(_vbox);
         var _loc1_:String = _type == 1 ? "asset.ylexdition.ydCurrLv" : "asset.ylexdition.ydNextLv";
         if(_type == 1)
         {
            _title.initParams(_loc1_,"asset.ChildPatrolTowerAffectView.NumBmpData",17,17,14,17,"0123456789",105,1);
         }
         else
         {
            _title.initParams(_loc1_,"asset.ChildPatrolTowerAffectView.NumBmpData",17,17,14,17,"0123456789",130,1);
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:FilterFrameText in _list)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _list = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

