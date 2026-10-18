package year2023.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.YearActiveManager;
   import theseuspvp.item.TheseusPvpGItemView;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SpeicalRewardTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   
   public class YearActivePrivateItem extends Sprite
   {
      
      private var _prItemIdxTxt:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _temp:SpeicalRewardTempInfo;
      
      private var _idx:int;
      
      private var _freeRewardItem:TheseusPvpGItemView;
      
      private var _adVanceRewardVbox:VBox;
      
      private var _getBtn:BaseButton;
      
      private var _advaneList:Array = [];
      
      private var _loginFlg:Bitmap;
      
      private var _todayFlg:Bitmap;
      
      private var _buqianBtn:BaseButton;
      
      public var buqPoint:int;
      
      public function YearActivePrivateItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.yearactive.day.bg2");
         _prItemIdxTxt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.prItemIdxTxt");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.gloryitemGetBtn");
         _freeRewardItem = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.gloryBaseItem");
         _freeRewardItem.lockState(false);
         _freeRewardItem.gouState(false);
         _adVanceRewardVbox = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.privateVbox");
         _todayFlg = ComponentFactory.Instance.creatBitmap("asset.yearactive.DateItemToday");
         _loginFlg = ComponentFactory.Instance.creatBitmap("asset.yearactive.CheckedImg");
         _buqianBtn = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.bqBtn");
         addChild(_bg);
         addChild(_prItemIdxTxt);
         addChild(_freeRewardItem);
         addChild(_adVanceRewardVbox);
         addChild(_getBtn);
         addChild(_todayFlg);
         addChild(_loginFlg);
         addChild(_buqianBtn);
         _getBtn.enable = false;
         _loginFlg.visible = false;
         _todayFlg.visible = false;
         _buqianBtn.visible = false;
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",getClickHandler);
         _buqianBtn.addEventListener("click",buqianClickHandler);
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",getClickHandler);
         _buqianBtn.removeEventListener("click",buqianClickHandler);
      }
      
      private function buqianClickHandler(param1:MouseEvent) : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point < buqPoint)
         {
            RechargeAlertMannager.show();
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc3_:String = LanguageMgr.GetTranslation("yearactivity.buqian.ContentText",buqPoint);
         SharedManagerHelper.ins.needAlert("yearactive.day.buqian",bqCallHandler,_loc2_,_loc3_);
      }
      
      private function bqCallHandler() : void
      {
         YearActiveManager.ins.doSomething(4,_temp.Gear);
      }
      
      private function getClickHandler(param1:MouseEvent) : void
      {
         YearActiveManager.ins.doSomething(2,_temp.Gear);
      }
      
      public function updateBtnState(param1:Dictionary, param2:int, param3:Boolean) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         if(_temp)
         {
            if(param2 == _temp.Gear)
            {
               _todayFlg.visible = true;
            }
            else
            {
               _todayFlg.visible = false;
            }
            if(param1[_temp.Gear] != null)
            {
               _loginFlg.visible = true;
               _buqianBtn.visible = false;
               _loc6_ = int(param1[_temp.Gear]);
               if(_loc6_ == 3)
               {
                  _getBtn.visible = false;
                  _freeRewardItem.gouState(true);
                  for each(_loc4_ in _advaneList)
                  {
                     _loc4_.lockState(!param3);
                     _loc4_.gouState(param3);
                  }
               }
               else if(_loc6_ == 2)
               {
                  _getBtn.visible = true;
                  _getBtn.enable = param3;
                  _freeRewardItem.gouState(true);
                  for each(_loc4_ in _advaneList)
                  {
                     _loc4_.lockState(!param3);
                     _loc4_.gouState(false);
                  }
               }
               else if(_loc6_ == 1)
               {
                  _getBtn.visible = true;
                  _getBtn.enable = true;
                  _freeRewardItem.gouState(false);
                  for each(_loc4_ in _advaneList)
                  {
                     _loc4_.lockState(!param3);
                     _loc4_.gouState(false);
                  }
               }
            }
            else
            {
               _loginFlg.visible = false;
               _freeRewardItem.gouState(false);
               for each(var _loc5_:TheseusPvpGItemView in _advaneList)
               {
                  _loc5_.lockState(!param3);
                  _loc5_.gouState(false);
               }
               if(param2 > _temp.Gear)
               {
                  _buqianBtn.visible = true;
                  _getBtn.visible = false;
               }
               else if(param2 < _temp.Gear)
               {
                  _getBtn.visible = true;
                  _getBtn.enable = false;
                  _buqianBtn.visible = false;
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
            _prItemIdxTxt.text = LanguageMgr.GetTranslation("yearactivity.xDay",_temp.Gear);
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
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TheseusPvpGItemView in _advaneList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _advaneList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_prItemIdxTxt);
         _prItemIdxTxt = null;
         ObjectUtils.disposeObject(_adVanceRewardVbox);
         _adVanceRewardVbox = null;
         ObjectUtils.disposeObject(_freeRewardItem);
         _freeRewardItem = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_loginFlg);
         _loginFlg = null;
         ObjectUtils.disposeObject(_todayFlg);
         _todayFlg = null;
         ObjectUtils.disposeObject(_buqianBtn);
         _buqianBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

