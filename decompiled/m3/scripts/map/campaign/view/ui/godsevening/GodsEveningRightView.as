package map.campaign.view.ui.godsevening
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.GodsEveningEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.godsevening.GodsEveningModel;
   import ui.tasktracebar.view.SpaceMapButtonView;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class GodsEveningRightView extends Component
   {
      
      private var _serverTaskView:GodsEveningTaskView;
      
      private var _personTaskView:GodsEveningTaskView;
      
      private var _mapBtn:SpaceMapButtonView;
      
      private var _selfInfoView:GodsEveningSelfInfoView;
      
      private var _inspireBtn:IconButton;
      
      private var _inspireBitmap:Bitmap;
      
      private var _inspireContainer:Sprite;
      
      private var _model:GodsEveningModel = GodsEveningManager.instance.model;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      private var _currencyInfo:PlayerCurrencyInfo = PlayerCurrencyManager.instance.currencyInfo;
      
      private var _inspireCost:int;
      
      public function GodsEveningRightView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _serverTaskView = new GodsEveningTaskView(1);
         _personTaskView = new GodsEveningTaskView(2);
         _selfInfoView = new GodsEveningSelfInfoView();
         _mapBtn = ComponentFactory.Instance.creatCustomObject("taskTrace.SpaceMapButtonView");
         _inspireBtn = ComponentFactory.Instance.creatComponentByStylename("GodsEveningRightView.InspireBtn");
         _inspireBitmap = ComponentFactory.Instance.creatBitmap("asset.GodsEveningRightView.InspireBitmap");
         _inspireContainer = ComponentFactory.Instance.creatCustomObject("GodsEveningRightView.inspireContainer");
         _inspireBtn.addChild(_inspireContainer);
         addChild(_serverTaskView);
         addChild(_personTaskView);
         _personTaskView.y = 195;
         addChild(_selfInfoView);
         _selfInfoView.y = 390;
         addChild(_mapBtn);
         _mapBtn.x = 20;
         _mapBtn.y = 500;
         addChild(_inspireBtn);
         _inspireCost = ConfigInfoManager.instance.getGodsInspireCost();
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_serverTaskView);
         _serverTaskView = null;
         ObjectUtils.disposeObject(_personTaskView);
         _personTaskView = null;
         ObjectUtils.disposeObject(_selfInfoView);
         _selfInfoView = null;
         ObjectUtils.disposeObject(_mapBtn);
         _mapBtn = null;
         ObjectUtils.disposeObject(_inspireBtn);
         _inspireBtn = null;
         ObjectUtils.disposeObject(_inspireBitmap);
         _inspireBitmap = null;
         ObjectUtils.disposeObject(_inspireContainer);
         _inspireContainer = null;
      }
      
      private function addEvent() : void
      {
         _inspireBtn.addEventListener("click",__inspireBtnClickHandler);
         GodsEveningManager.instance.addEventListener("INSPIRE_INFO",__inspireInfoHandler);
      }
      
      private function removeEvent() : void
      {
         if(_inspireBtn)
         {
            _inspireBtn.removeEventListener("click",__inspireBtnClickHandler);
         }
         GodsEveningManager.instance.removeEventListener("INSPIRE_INFO",__inspireInfoHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      private function __inspireInfoHandler(param1:GodsEveningEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         _inspireContainer.x = 66;
         NumberViewUtils.getNumberView(_model.inspireLevel,_inspireContainer,_inspireBitmap.bitmapData,13,21,13,13,"0123456789",1);
      }
      
      private function __inspireBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:String = null;
         if(_model.inspireLevel >= 10)
         {
            _loc6_ = LanguageMgr.GetTranslation("godsEvening.inspire.tip01");
            MessageTipManager.instance().show(_loc6_);
            return;
         }
         SimpleAlertHelper.instance.data = [inspireCallBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("godsEvening.inspire.tip02",_inspireCost,5);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc4_,_loc2_,_loc3_,true,true);
      }
      
      private function inspireCallBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Number = NaN;
         if(param1)
         {
            _loc3_ = _playerInfo.point * 10;
            if(_loc3_ < _inspireCost * 10)
            {
               RechargeAlertMannager.show();
               return;
            }
            GodsEveningManager.instance.sendInspire(0);
         }
      }
      
      override public function get height() : Number
      {
         return 515;
      }
      
      override public function get width() : Number
      {
         return 215;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false);
      }
   }
}

