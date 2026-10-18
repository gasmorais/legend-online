package demonland
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.gameplot.PlotMsg;
   import com.road.yishi.proto.module.EvilLandMsg;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.demonland.DemonLandModel;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.manager.DemonLandManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.MagicSpringBufferAddView;
   
   public class DemonLandFrame extends Frame
   {
      
      private var _txtDesc:FilterFrameText;
      
      private var _txtItemCount:FilterFrameText;
      
      private var _txtStrOwn:FilterFrameText;
      
      private var _barbg:Image;
      
      private var _bar:Image;
      
      private var _imgTitle:Image;
      
      private var _bg2:Image;
      
      private var _str1:Image;
      
      private var _bg1:Image;
      
      private var _mapRoad:DemonLandMapRoad;
      
      private var _btnAddCount:BaseButton;
      
      private var _imgTear:Image;
      
      private var _imgTearTip:ScaleFrameImage;
      
      private var arrBox:Array;
      
      private var spBox:Sprite;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      public function DemonLandFrame()
      {
         super();
         initView();
         initBufferView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc2_:AwardBox = null;
         var _loc3_:int = 0;
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandFrame.bg1");
         addToContent(_bg1);
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandFrame.bg2");
         addToContent(_bg2);
         _imgTitle = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandFrame.imgTitle");
         addToContent(_imgTitle);
         _txtDesc = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandFrame.txtDesc");
         addToContent(_txtDesc);
         _txtItemCount = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandFrame.txtItemCount");
         addToContent(_txtItemCount);
         _txtStrOwn = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandFrame.txtStrOwn");
         addToContent(_txtStrOwn);
         _barbg = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandFrame.barbg");
         addToContent(_barbg);
         _bar = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandFrame.bar");
         addToContent(_bar);
         _str1 = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandFrame.str1");
         addToContent(_str1);
         _imgTear = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandFrame.imgTear");
         addToContent(_imgTear);
         _imgTearTip = ComponentFactory.Instance.creatComponentByStylename("DemonLand.tearTip");
         var _loc1_:String = TempleteManager.instance.getConfigInfoByConfigName("evilland_goddess_tear_config").ConfigValue;
         _imgTearTip.tipData = LanguageMgr.GetTranslation("demonland.main.text8",int(_loc1_.split(",")[1]));
         addToContent(_imgTearTip);
         spBox = new Sprite();
         addToContent(spBox);
         spBox.x = -50;
         arrBox = [];
         _loc3_ = 1;
         while(_loc3_ <= 6)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("DemonLand.DemonLandFrame.box" + _loc3_,[_loc3_]);
            spBox.addChild(_loc2_);
            arrBox.push(_loc2_);
            _loc3_++;
         }
         _mapRoad = ComponentFactory.Instance.creatCustomObject("DemonLand.DemonLandFrame.mapRoad");
         addToContent(_mapRoad);
         _btnAddCount = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandFrame.btnAddCount");
         addToContent(_btnAddCount);
         _txtStrOwn.text = LanguageMgr.GetTranslation("demonland.main.text1");
         _txtDesc.text = LanguageMgr.GetTranslation("demonland.main.text2");
         DemonLandManager.instance.sendGetDemonLandData();
         setProgress(1);
      }
      
      private function setProgress(param1:int) : void
      {
         param1 = Math.min(param1,30);
         _mapRoad.setProgress(param1);
         if(param1 <= 5)
         {
            _bar.width = 0;
         }
         else
         {
            _bar.width = _barbg.width * (param1 - 5) / 25;
         }
      }
      
      private function initBufferView() : void
      {
         var _loc1_:String = null;
         var _loc2_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(21);
         if(_loc2_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc2_);
            _loc1_ = LanguageMgr.GetTranslation("home.demonLandFrame.bufferText",_loc2_.tempInfo.AddValue);
            _bufferView.setDescText(_loc1_);
            _bufferView.x = 757;
            _bufferView.y = 121;
            addToContent(_bufferView);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btnAddCount.addEventListener("click",_btnAddCountClickHandler);
         NotificationManager.instance.addEventListener("DEMON_LAND_DATA",updateData);
         NotificationManager.instance.addEventListener("DEMON_LAND_DIALOG",receiveDialog);
      }
      
      private function _btnAddCountClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:String = TempleteManager.instance.getConfigInfoByConfigName("evilland_goddess_tear_config").ConfigValue;
         var _loc7_:int = int(OldPlayerReturnManager.instance.model.demonLandCount);
         var _loc5_:int = int(_loc4_.split(",")[2]) + _loc7_ - DemonLandManager.instance.model.tearBuyCount;
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         var _loc6_:String = LanguageMgr.GetTranslation("demonland.main.text5",int(_loc4_.split(",")[3]),_loc5_);
         SimpleAlertHelper.instance.data = [realBuy];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc8_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc6_,_loc2_,_loc3_,true,true);
      }
      
      private function realBuy(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            DemonLandManager.instance.sendBuyTear();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btnAddCount)
         {
            _btnAddCount.removeEventListener("click",_btnAddCountClickHandler);
         }
         NotificationManager.instance.removeEventListener("DEMON_LAND_DATA",updateData);
         NotificationManager.instance.removeEventListener("DEMON_LAND_DIALOG",receiveDialog);
      }
      
      private function receiveDialog(param1:NotificationEvent) : void
      {
         var _loc2_:PlotMsg = param1.data;
         if(!_loc2_.loop)
         {
            FrameControllerManager.instance.openControllerByInfo("demonland",2);
         }
      }
      
      private function updateData(param1:NotificationEvent) : void
      {
         var _loc2_:EvilLandMsg = param1.data;
         if(_loc2_.type == 0)
         {
            setProgress(_loc2_.chapterId);
         }
         if(_loc2_.type == 1)
         {
            setProgress(_loc2_.chapterId);
         }
         _txtItemCount.text = DemonLandManager.instance.model.myTear + "/" + DemonLandModel.MAX_TEAR;
         for each(var _loc3_:AwardBox in arrBox)
         {
            _loc3_.update();
         }
      }
      
      private function get model() : DemonLandModel
      {
         return DemonLandManager.instance.model;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_txtDesc);
         _txtDesc = null;
         ObjectUtils.disposeObject(_txtItemCount);
         _txtItemCount = null;
         ObjectUtils.disposeObject(_txtStrOwn);
         _txtStrOwn = null;
         ObjectUtils.disposeObject(_barbg);
         _barbg = null;
         ObjectUtils.disposeObject(_bar);
         _bar = null;
         ObjectUtils.disposeObject(_imgTitle);
         _imgTitle = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_str1);
         _str1 = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_mapRoad);
         _mapRoad = null;
         ObjectUtils.disposeObject(_btnAddCount);
         _btnAddCount = null;
         ObjectUtils.disposeObject(_imgTear);
         _imgTear = null;
         ObjectUtils.disposeObject(_imgTearTip);
         _imgTearTip = null;
         ObjectUtils.disposeAllChildren(spBox);
         spBox = null;
         LogicUtils.disposeDisplayCollection(arrBox);
         arrBox = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         super.dispose();
      }
   }
}

