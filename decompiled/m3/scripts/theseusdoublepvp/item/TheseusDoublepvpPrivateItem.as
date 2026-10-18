package theseusdoublepvp.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.TheseusPvpManager;
   import theseuspvp.item.TheseusPvpGItemView;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SpeicalRewardTempInfo;
   
   public class TheseusDoublepvpPrivateItem extends Sprite
   {
      
      public var _privateitemBg:ScaleFrameImage;
      
      public var _prItemIdxTxt:FilterFrameText;
      
      public var _privateItemGloryIcon:Image;
      
      public var _prItemVTxt:FilterFrameText;
      
      private var _temp:SpeicalRewardTempInfo;
      
      private var _idx:int;
      
      private var _freeRewardItem:TheseusPvpGItemView;
      
      private var _adVanceRewardVbox:VBox;
      
      private var _getBtn:BaseButton;
      
      private var _advaneList:Array = [];
      
      public function TheseusDoublepvpPrivateItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _privateitemBg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.privateitemBg");
         _prItemIdxTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.prItemIdxTxt");
         _privateItemGloryIcon = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.privateItemGloryIcon");
         _prItemVTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.prItemVTxt");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.gloryitemGetBtn");
         _freeRewardItem = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.gloryBaseItem");
         _freeRewardItem.lockState(false);
         _freeRewardItem.gouState(false);
         _adVanceRewardVbox = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.privateVbox");
         addChild(_privateitemBg);
         addChild(_prItemIdxTxt);
         addChild(_privateItemGloryIcon);
         addChild(_prItemVTxt);
         addChild(_freeRewardItem);
         addChild(_adVanceRewardVbox);
         addChild(_getBtn);
         _getBtn.enable = false;
         _privateitemBg.setFrame(1);
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",getClickHandler);
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",getClickHandler);
      }
      
      private function getClickHandler(param1:MouseEvent) : void
      {
         if(_temp)
         {
            TheseusPvpManager.Instance.doSomething1(10,_temp.Gear);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TheseusPvpGItemView in _advaneList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _advaneList = null;
         ObjectUtils.disposeObject(_privateitemBg);
         _privateitemBg = null;
         ObjectUtils.disposeObject(_prItemIdxTxt);
         _prItemIdxTxt = null;
         ObjectUtils.disposeObject(_privateItemGloryIcon);
         _privateItemGloryIcon = null;
         ObjectUtils.disposeObject(_prItemVTxt);
         _prItemVTxt = null;
         ObjectUtils.disposeObject(_adVanceRewardVbox);
         _adVanceRewardVbox = null;
         ObjectUtils.disposeObject(_freeRewardItem);
         _freeRewardItem = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function updateBtnState(param1:Array, param2:int, param3:Boolean) : void
      {
         if(_temp)
         {
            if(param1.indexOf(_temp.Gear) != -1)
            {
               _getBtn.visible = false;
               _freeRewardItem.gouState(true);
               for each(var _loc4_:TheseusPvpGItemView in _advaneList)
               {
                  _loc4_.lockState(!param3);
                  _loc4_.gouState(param3);
               }
            }
            else
            {
               _getBtn.visible = true;
               _freeRewardItem.gouState(false);
               _getBtn.enable = param2 >= _temp.NeedNum;
               for each(var _loc5_:TheseusPvpGItemView in _advaneList)
               {
                  _loc5_.lockState(!param3);
                  _loc5_.gouState(false);
               }
            }
         }
      }
      
      public function get temp() : SpeicalRewardTempInfo
      {
         return _temp;
      }
      
      public function set temp(param1:SpeicalRewardTempInfo) : void
      {
         var _loc8_:Array = null;
         var _loc7_:GoodsInfo = null;
         var _loc5_:Array = null;
         var _loc2_:TheseusPvpGItemView = null;
         var _loc3_:Array = null;
         var _loc6_:String = null;
         var _loc4_:int = 0;
         _temp = param1;
         if(_temp)
         {
            visible = true;
            _prItemVTxt.text = "" + _temp.NeedNum;
            _prItemIdxTxt.text = "" + _temp.Gear;
            _loc8_ = _temp.FreeReward.split(",");
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = int(_loc8_[0]);
            _loc7_.count = int(_loc8_[1]);
            _freeRewardItem.data = _loc7_;
            if(_temp.PayReward.length > 1)
            {
               _loc5_ = _temp.PayReward.split("|");
               _adVanceRewardVbox.beginChanges();
               _adVanceRewardVbox.removeAllChild();
               _loc4_ = 0;
               while(_loc4_ < _loc5_.length)
               {
                  _loc6_ = _loc5_[_loc4_];
                  _loc3_ = _loc6_.split(",");
                  if(_loc4_ >= _advaneList.length)
                  {
                     _loc2_ = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.gloryBaseItemView");
                     _advaneList.push(_loc2_);
                  }
                  else
                  {
                     _loc2_ = _advaneList[_loc4_];
                  }
                  _loc7_ = new GoodsInfo();
                  _loc7_.templateId = int(_loc3_[0]);
                  _loc7_.count = int(_loc3_[1]);
                  _loc2_.data = _loc7_;
                  _loc2_.gouState(false);
                  _adVanceRewardVbox.addChild(_loc2_);
                  _loc4_++;
               }
               _adVanceRewardVbox.commitChanges();
            }
         }
         else
         {
            visible = false;
         }
      }
      
      public function get idx() : int
      {
         return _idx;
      }
      
      public function set idx(param1:int) : void
      {
         _idx = param1;
         _prItemIdxTxt.text = "" + _idx;
      }
   }
}

