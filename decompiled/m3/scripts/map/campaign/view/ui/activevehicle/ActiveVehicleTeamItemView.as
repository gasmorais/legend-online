package map.campaign.view.ui.activevehicle
{
   import chat.datas.ChatData;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import map.campaign.data.CampaignArmy;
   import map.campaign.event.CampaignEvent;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ActiveVehicleTeamItemView extends Component implements IManualSize
   {
      
      private var _bloodBack:Bitmap;
      
      private var _bloodMc:MovieClip;
      
      private var _data:CampaignArmy;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _head:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _rect:Rectangle = new Rectangle(0,0,88,70);
      
      private var _chatPopView:ActiveVehicleTeamChatPopView;
      
      private var _timeId:int;
      
      public function ActiveVehicleTeamItemView()
      {
         this.width = 88;
         this.height = 70;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.teamGrade");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.teamNameTxt");
         _head = ComponentFactory.Instance.creatCustomObject("ActiveVehicleTeamItemView.teamHead");
         _bloodBack = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.TeamBloodBack");
         _bloodMc = ComponentFactory.Instance.creat("asset.vehiclemap.TeamBlood");
         _bloodMc.gotoAndStop(80);
         _bloodMc.x = 14;
         _bloodMc.y = 45;
         addChild(_bloodBack);
         _bloodBack.y = 42;
         addChild(_bloodMc);
         addChild(_gradeTxt);
         addChild(_nameTxt);
         addChild(_head);
      }
      
      public function get data() : CampaignArmy
      {
         return _data;
      }
      
      public function set data(param1:CampaignArmy) : void
      {
         removeEvent();
         _data = param1;
         update();
         addEvent();
      }
      
      public function update() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         _head.visible = false;
         if(_data)
         {
            this.visible = true;
            _nameTxt.text = _data.baseHero.nickName;
            _gradeTxt.text = String(_data.activeGrade);
            _loc1_ = IconFactory.getHeadIcon(_data.baseHero.headId,"head");
            if(_loc1_ != _head.icon)
            {
               _head.icon = _loc1_;
            }
            _head.visible = true;
            _loc2_ = _data.activeCurHp * 100 / _data.activeTotalHp;
            _bloodMc.gotoAndStop(_loc2_);
         }
         else
         {
            this.visible = false;
            _nameTxt.text = "";
            _gradeTxt.text = "";
            _head.icon = null;
            _bloodMc.gotoAndStop(0);
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      private function addEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("ACTIVEVEHICLE_CHATDATA",__showChatPopHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("ACTIVEVEHICLE_CHATDATA",__showChatPopHandler);
         }
      }
      
      private function __showChatPopHandler(param1:CampaignEvent) : void
      {
         var _loc2_:ChatData = param1.data as ChatData;
         if(_chatPopView)
         {
            _chatPopView.dispose();
            _chatPopView = null;
         }
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
         }
         _chatPopView = new ActiveVehicleTeamChatPopView();
         _chatPopView.x = 83;
         _chatPopView.y = 0;
         _chatPopView.setChatData(_loc2_);
         addChild(_chatPopView);
         _timeId = setTimeout(closePopView,3000);
      }
      
      private function closePopView() : void
      {
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
         }
         _timeId = 0;
         if(_chatPopView)
         {
            _chatPopView.dispose();
            _chatPopView = null;
         }
      }
      
      override public function dispose() : void
      {
         if(_chatPopView)
         {
            ObjectUtils.disposeObject(_chatPopView);
         }
         _chatPopView = null;
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
         }
         _timeId = 0;
         removeEvent();
         if(_bloodBack)
         {
            ObjectUtils.disposeObject(_bloodBack);
         }
         _bloodBack = null;
         if(_bloodMc)
         {
            ObjectUtils.disposeViolentMc(_bloodMc);
         }
         _bloodMc = null;
         if(_gradeTxt)
         {
            ObjectUtils.disposeObject(_gradeTxt);
         }
         _gradeTxt = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_head)
         {
            ObjectUtils.disposeObject(_head);
         }
         _head = null;
         super.dispose();
      }
   }
}

