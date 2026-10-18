package com.map.vehicle.view
{
   import chat.view.ChatItemMenu;
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.VehicleAccountInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.TextEvent;
   
   public class VehicleAccountItemView extends Component
   {
      
      private var _sortIndexTxt:FilterFrameText;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _flag:ScaleFrameImage;
      
      private var _data:PlayerVehicleInfo;
      
      private var _index:int;
      
      private var _info:VehicleAccountInfo;
      
      private var _menu:ChatItemMenu;
      
      public function VehicleAccountItemView(param1:int, param2:VehicleAccountInfo)
      {
         _index = param1;
         _info = param2;
         this.height = 32;
         super();
      }
      
      public function get data() : PlayerVehicleInfo
      {
         return _data;
      }
      
      public function set data(param1:PlayerVehicleInfo) : void
      {
         removeEvent();
         _data = param1;
         if(_data)
         {
            _sortIndexTxt.text = String(_index);
            _scoreTxt.text = String(_data.score);
            _flag.visible = true;
            _flag.setFrame(_data.team);
            if(_data.team == _info.myTeamId)
            {
               _nickNameTxt.setFrame(1);
            }
            else
            {
               _nickNameTxt.setFrame(2);
            }
            _nickNameTxt.htmlText = "<a href =\'event: \'><u> " + _data.name + " </u></a>";
            _nickNameTxt.mouseEnabled = true;
            addEvent();
         }
         else
         {
            _sortIndexTxt.text = "";
            _nickNameTxt.text = "";
            _scoreTxt.text = "";
            _flag.visible = false;
         }
      }
      
      private function addEvent() : void
      {
         _nickNameTxt.addEventListener("link",__onLinkHandler);
      }
      
      private function removeEvent() : void
      {
         _nickNameTxt.removeEventListener("link",__onLinkHandler);
      }
      
      private function __onLinkHandler(param1:TextEvent) : void
      {
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         if(!_data)
         {
            return;
         }
         var _loc2_:Boolean = false;
         _menu = new ChatItemMenu(_data.name,_data.playerId,_loc2_);
         LayerManager.Instance.addToLayer(_menu,7);
         _menu.x = StageReferance.stage.mouseX;
         _menu.y = StageReferance.stage.mouseY + 7;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         super.dispose();
      }
      
      override protected function init() : void
      {
         _sortIndexTxt = ComponentFactory.Instance.creatComponentByStylename("vehicle.sortitem.IndexTxt");
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("pvpmap.sortitem.NickNameTxt");
         _nickNameTxt.x = 106;
         _nickNameTxt.y = 6;
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("vehicle.sortitem.ScoreTxt");
         _flag = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.teamFlag");
         _flag.x = 82;
         _flag.y = 2;
         addChild(_sortIndexTxt);
         addChild(_flag);
         addChild(_nickNameTxt);
         addChild(_scoreTxt);
      }
   }
}

