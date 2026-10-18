package selectcampaign
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import events.SelectCampaignEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import managers.MagicSpringManager;
   import map.campaign.CampaignSocketOutManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import mvc.module.selectcampaign.SelectCampaignModel;
   import selectcampaign.view.AreaView;
   import selectcampaign.view.CampaignPointView;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SelectCampaignFrame extends Frame implements IManualSize
   {
      
      private var _areaView:AreaView;
      
      private var _border:DisplayObject;
      
      private var _bufferView1:MagicSpringBufferAddView;
      
      private var _bufferView2:MagicSpringBufferAddView;
      
      private var tempNeedPoint:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("single_hero_buy_cost");
      
      public var needPoint:int = tempNeedPoint ? int(tempNeedPoint.ConfigValue) : 10;
      
      private var _helpBtn:BaseButton;
      
      private var _rect:Rectangle = new Rectangle(0,0,930,550);
      
      public function SelectCampaignFrame()
      {
         CampaignSocketOutManager.instance.buyCount(1);
         super();
         initView();
         initBufferView();
         initEvents();
         __selectedChapterChangeHandler(null);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      private function initView() : void
      {
         _areaView = ComponentFactory.Instance.creatCustomObject("selectCP.AreaView");
         addToContent(_areaView);
         _border = ComponentFactory.Instance.creatCustomObject("selectCP.framestyleCp");
         addToContent(_border);
         _border.width = 1020;
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("selectCP.helpBtn");
         addToContent(_helpBtn);
      }
      
      private function initBufferView() : void
      {
         var _loc1_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(3);
         if(_loc1_)
         {
            _bufferView1 = new MagicSpringBufferAddView(_loc1_);
            _bufferView1.setDescText(_loc1_.tempInfo.Desc);
            _bufferView1.x = 720;
            _bufferView1.y = 25;
            addToContent(_bufferView1);
         }
         var _loc2_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(4);
         if(_loc2_)
         {
            _bufferView2 = new MagicSpringBufferAddView(_loc2_);
            _bufferView2.setDescText(_loc2_.tempInfo.Desc);
            _bufferView2.x = 720;
            if(_bufferView1 && _bufferView1.parent)
            {
               _bufferView2.y = _bufferView1.y + 40;
            }
            else
            {
               _bufferView2.y = 25;
            }
            addToContent(_bufferView2);
         }
      }
      
      private function initEvents() : void
      {
         addEventListener("addedToStage",__addToStage);
         addEventListener("response",__frameResponseHandler);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
         _helpBtn.addEventListener("click",__helpHandler);
         model.addEventListener("SELECTED_CHAPTER_CHANGE",__selectedChapterChangeHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("addedToStage",__addToStage);
         removeEventListener("response",__frameResponseHandler);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__switchSceneHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
         model.removeEventListener("SELECTED_CHAPTER_CHANGE",__selectedChapterChangeHandler);
      }
      
      private function __selectedChapterChangeHandler(param1:SelectCampaignEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Boolean = false;
         var _loc2_:Vector.<CampaignPointView> = _areaView.cpMapView.pointViewArr;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_].ExistDiff())
            {
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         _loc2_ = ComponentFactory.Instance.creatComponentByStylename("selectCP.helpFrame");
         _loc2_.show();
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __addToStage(param1:Event) : void
      {
      }
      
      public function show() : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OPEN_CAMPAIGN_FRAME",null));
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function get areaView() : AreaView
      {
         return _areaView;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : SelectCampaignModel
      {
         return FrameControllerManager.instance.selectCampaignControler.model;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         KeyBoardRegister.instance.keyEnable = true;
         if(_areaView)
         {
            _areaView.dispose();
         }
         _areaView = null;
         ObjectUtils.disposeObject(_bufferView1);
         _bufferView1 = null;
         ObjectUtils.disposeObject(_bufferView2);
         _bufferView2 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

