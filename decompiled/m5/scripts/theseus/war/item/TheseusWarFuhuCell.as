package theseus.war.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusWarsoulHatchInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.WarSoulTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusWarFuhuCell extends Sprite
   {
      
      public var _warfuhuCellBg:Bitmap;
      
      public var _warLu:Bitmap;
      
      public var _warFuhuCellProBg1:Bitmap;
      
      public var _warFuhuCellProBg2:Bitmap;
      
      public var _fhCellBtn2:IconButton;
      
      public var _fhCellBtn1:IconButton;
      
      public var _fhuaProgress:FilterFrameText;
      
      public var _fuhufNameTxt:FilterFrameText;
      
      private var _maskPro:Shape;
      
      private var _cd:TimeDownView;
      
      private var _cdBtn:BaseButton;
      
      private var _state:int;
      
      private var _data:TheseusWarsoulHatchInfo;
      
      private var _fastParam:Array = [60,100];
      
      private var _idx:int;
      
      private var _warMinTemp:WarSoulTempInfo;
      
      private var _useItem:int = -1;
      
      public function TheseusWarFuhuCell(param1:int)
      {
         super();
         _idx = param1;
         initView();
         initEvent();
      }
      
      public function get idx() : int
      {
         return _idx;
      }
      
      public function get data() : TheseusWarsoulHatchInfo
      {
         return _data;
      }
      
      public function set data(param1:TheseusWarsoulHatchInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc4_:Array = null;
         _data = param1;
         if(_data && _data.stopTime)
         {
            if(playerModel.nowDate < _data.stopTime.time && _data.useItem > 0)
            {
               state = 2;
               _cd.removeEventListener("timerDown_complete",timeCompleteHandler);
               _cd.addEventListener("timerDown_complete",timeCompleteHandler);
               _loc3_ = (_data.stopTime.time - playerModel.nowDate) / 1000;
               if(_loc3_ < 0)
               {
                  _loc3_ = 0;
               }
               _cd.timeCount = _loc3_;
            }
            else if(playerModel.nowDate >= _data.stopTime.time)
            {
               state = 1;
            }
         }
         else
         {
            state = 0;
         }
         if(_data)
         {
            if(_useItem != _data.useItem)
            {
               _useItem = _data.useItem;
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_useItem);
               _loc4_ = TempleteManager.instance.warsoulCate.getListBySontype(_loc2_.Property7);
               _warMinTemp = _loc4_[0];
               _fuhufNameTxt.text = _warMinTemp.Name;
            }
         }
         else
         {
            _warMinTemp = null;
            _useItem = -1;
            _fuhufNameTxt.text = "";
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function initView() : void
      {
         _warfuhuCellBg = ComponentFactory.Instance.creatBitmap("asset.theseus.warfuhuCellBg");
         _warLu = ComponentFactory.Instance.creatBitmap("asset.theseus.warLu");
         _warFuhuCellProBg1 = ComponentFactory.Instance.creatBitmap("asset.theseus.warFuhuCellProBg1");
         _warFuhuCellProBg2 = ComponentFactory.Instance.creatBitmap("asset.theseus.warFuhuCellProBg2");
         _fhCellBtn2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.fhCellBtn2");
         _fhCellBtn1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.fhCellBtn1");
         _fhuaProgress = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.fhuaProgress");
         _fuhufNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.cellfuhufNameTxt");
         _cd = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.fuhua.reduceTimeCd");
         _cdBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.aduceTimeBtn");
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("warsoul_hatch_fast");
         if(_loc1_)
         {
            _fastParam = _loc1_.ConfigValue.split(",");
         }
         _maskPro = new Shape();
         _maskPro.graphics.beginFill(16711680);
         _maskPro.graphics.drawRect(0,0,_warFuhuCellProBg1.width,_warFuhuCellProBg1.height);
         _maskPro.graphics.endFill();
         _maskPro.x = _warFuhuCellProBg1.x;
         _maskPro.y = _warFuhuCellProBg1.y;
         addChild(_warfuhuCellBg);
         addChild(_warLu);
         addChild(_warFuhuCellProBg1);
         addChild(_warFuhuCellProBg2);
         addChild(_maskPro);
         addChild(_fhCellBtn2);
         addChild(_fhCellBtn1);
         addChild(_fhuaProgress);
         addChild(_fuhufNameTxt);
         addChild(_cd);
         addChild(_cdBtn);
         _warFuhuCellProBg2.mask = _maskPro;
         state = 0;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
         switch(_state)
         {
            case 0:
               _fhCellBtn1.visible = true;
               _fhCellBtn2.visible = false;
               _fhuaProgress.text = "";
               _cd.visible = false;
               _cdBtn.visible = false;
               _warFuhuCellProBg1.visible = false;
               _warFuhuCellProBg2.visible = false;
               break;
            case 1:
               _fhCellBtn1.visible = false;
               _fhCellBtn2.visible = true;
               _warFuhuCellProBg1.visible = true;
               _warFuhuCellProBg2.visible = true;
               _cd.visible = false;
               _cdBtn.visible = false;
               _fhuaProgress.text = LanguageMgr.GetTranslation("theseus.war.fuhuaComplete");
               break;
            case 2:
               _fhCellBtn1.visible = false;
               _fhCellBtn2.visible = false;
               _cd.visible = true;
               _cdBtn.visible = true;
               _warFuhuCellProBg1.visible = true;
               _warFuhuCellProBg2.visible = true;
               _fhuaProgress.text = LanguageMgr.GetTranslation("theseus.war.fuhuaProgress");
         }
      }
      
      private function updateProgress(param1:int, param2:int) : void
      {
         if(param1 > param2)
         {
            param1 = param2;
         }
         var _loc3_:int = _warFuhuCellProBg1.width * param1 / param2;
         _maskPro.graphics.clear();
         _maskPro.graphics.beginFill(16711680);
         _maskPro.graphics.drawRect(0,0,_loc3_,_warFuhuCellProBg1.height);
         _maskPro.graphics.endFill();
      }
      
      private function initEvent() : void
      {
         _fhCellBtn1.addEventListener("click",doFuhuaHandler);
         _fhCellBtn2.addEventListener("click",getHandler);
         _cdBtn.addEventListener("click",cdHandler);
      }
      
      private function removeEvent() : void
      {
         _fhCellBtn1.removeEventListener("click",doFuhuaHandler);
         _fhCellBtn2.removeEventListener("click",getHandler);
         _cdBtn.removeEventListener("click",cdHandler);
         _cd.removeEventListener("timerDown_complete",timeCompleteHandler);
      }
      
      private function timeCompleteHandler(param1:Event) : void
      {
         _cd.removeEventListener("timerDown_complete",timeCompleteHandler);
         state = 1;
      }
      
      private function doFuhuaHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("theseussoul",4,_idx);
      }
      
      private function getHandler(param1:MouseEvent) : void
      {
         var _loc3_:Array = null;
         var _loc2_:int = 0;
         if(_state == 1)
         {
            _loc3_ = [];
            if(_warMinTemp)
            {
               _loc3_ = TheseussoulManager.Instance.warsoulModel.getListByMainType(_warMinTemp.MainType);
            }
            _loc2_ = 63;
            if(_loc3_.length >= _loc2_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.mainTypeBag" + _warMinTemp.MainType));
            }
            else
            {
               _fhCellBtn2.visible = false;
               TheseussoulManager.Instance.doWarsoulParam(9,_idx);
            }
         }
      }
      
      private function cdHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc7_:String = null;
         var _loc6_:String = null;
         var _loc8_:String = null;
         var _loc5_:int = int(_fastParam[1]);
         var _loc4_:int = int(_fastParam[0]);
         if(_loc5_ > playerModel.playerInfo.point)
         {
            RechargeAlertMannager.show();
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = DateFormatter.getConsortiaCountDate(_loc4_ * 60);
            _loc8_ = LanguageMgr.GetTranslation("theseus.war.fuhuaSpeed",_loc5_,_loc6_);
            SimpleAlertHelper.instance.data = [__alertResponse];
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc2_,_loc3_,false,true);
         }
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            TheseussoulManager.Instance.doWarsoulParam(8,_idx);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_warfuhuCellBg);
         _warfuhuCellBg = null;
         ObjectUtils.disposeObject(_warLu);
         _warLu = null;
         ObjectUtils.disposeObject(_warFuhuCellProBg1);
         _warFuhuCellProBg1 = null;
         ObjectUtils.disposeObject(_warFuhuCellProBg2);
         _warFuhuCellProBg2 = null;
         ObjectUtils.disposeObject(_fhCellBtn2);
         _fhCellBtn2 = null;
         ObjectUtils.disposeObject(_fhCellBtn1);
         _fhCellBtn1 = null;
         ObjectUtils.disposeObject(_fhuaProgress);
         _fhuaProgress = null;
         ObjectUtils.disposeObject(_fuhufNameTxt);
         _fuhufNameTxt = null;
         ObjectUtils.disposeObject(_cd);
         _cd = null;
         ObjectUtils.disposeObject(_cdBtn);
         _cdBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _fastParam = null;
         _data = null;
         _warMinTemp = null;
      }
   }
}

