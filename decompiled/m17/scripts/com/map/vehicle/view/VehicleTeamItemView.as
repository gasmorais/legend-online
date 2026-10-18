package com.map.vehicle.view
{
   import chat.datas.ChatData;
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.events.VehicleEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class VehicleTeamItemView extends Component implements IManualSize
   {
      
      private var _bloodBack:Bitmap;
      
      private var _bloodMc:MovieClip;
      
      private var _data:PlayerVehicleInfo;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _head:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _rect:Rectangle = new Rectangle(0,0,88,70);
      
      private var _chatPopView:VehicleTeamChatPopView;
      
      private var _timeId:int;
      
      public function VehicleTeamItemView()
      {
         this.width = 88;
         this.height = 70;
         super();
         initView();
         addEvent();
      }
      
      public function get data() : PlayerVehicleInfo
      {
         return _data;
      }
      
      public function set data(param1:PlayerVehicleInfo) : void
      {
         removeEvent();
         _data = param1;
         update();
         addEvent();
      }
      
      override public function dispose() : void
      {
         if(_chatPopView)
         {
            _chatPopView.dispose();
            _chatPopView = null;
         }
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
         }
         _timeId = 0;
         removeEvent();
         uintView();
         super.dispose();
      }
      
      public function update() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         _head.visible = false;
         if(_data)
         {
            this.visible = true;
            _nameTxt.text = _data.name;
            _gradeTxt.text = String(_data.grade);
            _loc1_ = IconFactory.getVehicleHeadIcon(_data.templateId);
            if(_loc1_ != _head.icon)
            {
               _head.icon = _loc1_;
            }
            _head.visible = true;
            _loc2_ = _data.hp * 100 / _data.totalHp;
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
            _data.addEventListener("CHAT_DATA",__showChatPopHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("CHAT_DATA",__showChatPopHandler);
         }
      }
      
      private function __showChatPopHandler(param1:VehicleEvent) : void
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
         _chatPopView = new VehicleTeamChatPopView();
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
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.teamGrade");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.teamNameTxt");
         _head = ComponentFactory.Instance.creatCustomObject("vehiclemap.teamHead");
         _bloodBack = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.TeamBloodBack");
         _bloodMc = ComponentFactory.Instance.creat("asset.vehiclemap.TeamBlood");
         _bloodMc.gotoAndStop(80);
         _bloodMc.x = 14;
         _bloodMc.y = 43;
         addChild(_bloodBack);
         addChild(_bloodMc);
         addChild(_gradeTxt);
         addChild(_nameTxt);
         addChild(_head);
         if(VGlobal.model.selfVehicleInfo)
         {
            _loc1_ = VGlobal.model.selfVehicleInfo.team;
         }
      }
      
      private function uintView() : void
      {
      }
   }
}

