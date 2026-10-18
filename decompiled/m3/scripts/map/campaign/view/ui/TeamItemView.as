package map.campaign.view.ui
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.event.CampaignMapEvent;
   import mvc.module.room.RoomInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.PlayerMenu;
   import yishi.view.tips.MultipleDictionaryInfo;
   
   public class TeamItemView extends Component
   {
      
      private var _bgAsset:MovieClip;
      
      private var _armyName:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _playerInfo:ThaneInfo;
      
      private var _playerIcon:BaseIconView;
      
      private var _captainMask:Image;
      
      private var _jobImg:ScaleFrameImage;
      
      private var _filter:IFilterFormat;
      
      private var _transeferMask:Bitmap;
      
      private var _data:CampaignArmy;
      
      public function TeamItemView()
      {
         super();
         _bgAsset = ComponentFactory.Instance.creatCustomObject("asset.campaign.map.ui.ArmyBgAsset");
         addChild(_bgAsset);
         _armyName = ComponentFactory.Instance.creatComponentByStylename("campaign.map.ui.ArmyNameTxt");
         addChild(_armyName);
         _playerIcon = ComponentFactory.Instance.creatCustomObject("campaign.tiemList.PlayerIcon");
         addChild(_playerIcon);
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.map.ui.LevelTxt");
         addChild(_levelTxt);
         _captainMask = ComponentFactory.Instance.creatComponentByStylename("campaign.room.TeamMask");
         _jobImg = ComponentFactory.Instance.creatComponentByStylename("campaign.room.JobImg");
         addChild(_jobImg);
         _playerIcon.mask = creatShape();
         _filter = new UIFilter();
         _transeferMask = ComponentFactory.Instance.creatBitmap("asset.campaign.transefer.TranseferWaitMaskAsset");
         buttonMode = true;
      }
      
      private function initEvents() : void
      {
         addEventListener("click",__click);
         addEventListener("rollOver",__over);
         addEventListener("rollOut",__out);
         if(_data)
         {
            _data.addEventListener("ONLINE_STATE",__onlineStateHandler);
            _data.addEventListener("transeferWaitState",__transeferWaitStateHandler);
         }
      }
      
      private function removeEvents() : void
      {
         removeEventListener("click",__click);
         removeEventListener("rollOver",__over);
         removeEventListener("rollOut",__out);
         if(_data)
         {
            _data.removeEventListener("ONLINE_STATE",__onlineStateHandler);
            _data.removeEventListener("transeferWaitState",__transeferWaitStateHandler);
         }
      }
      
      private function __transeferWaitStateHandler(param1:CampaignMapEvent) : void
      {
         if(_data && _data.transeferWaitState)
         {
            if(_transeferMask)
            {
               addChild(_transeferMask);
            }
         }
         else if(_transeferMask && _transeferMask.parent)
         {
            _transeferMask.parent.removeChild(_transeferMask);
         }
      }
      
      private function __click(param1:MouseEvent) : void
      {
         if(_data.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            return;
         }
         var _loc2_:PlayerMenu = new PlayerMenu();
         _loc2_.setData(_data.baseHero);
         _loc2_.x = StageReferance.stage.mouseX;
         _loc2_.y = StageReferance.stage.mouseY;
         LayerManager.Instance.addToLayer(_loc2_,7);
      }
      
      private function __out(param1:MouseEvent) : void
      {
         if(_data && _data.online)
         {
            _filter.setNormalFilter(this);
         }
      }
      
      private function __over(param1:MouseEvent) : void
      {
         if(_data && _data.online)
         {
            _filter.setLightingFilter(this);
         }
      }
      
      private function __onlineStateHandler(param1:CampaignMapEvent) : void
      {
         if(!_data)
         {
            return;
         }
         _data.online ? _filter.setNormalFilter(this) : _filter.setGrayFilter(this);
      }
      
      private function creatShape() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawCircle(20,20,15);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function initView() : void
      {
         var _loc1_:RoomInfo = null;
         if(_data)
         {
            _loc1_ = RoomManager.instance.roomInfo;
            _armyName.text = _data.nickName == null ? "" : _data.nickName;
            _playerIcon.icon = IconFactory.getHeadIcon(_data.baseHero.headId,"head");
            _levelTxt.text = String(_data.baseHero.grades);
            _jobImg.setFrame(_data.baseHero.templateInfo.Job);
            if(_loc1_)
            {
               if(_loc1_.houseOwnerId == _data.userId && _loc1_.serverName == _data.baseHero.serviceName)
               {
                  addChild(_captainMask);
               }
               else if(_captainMask.parent)
               {
                  _captainMask.parent.removeChild(_captainMask);
               }
            }
         }
         else
         {
            this.visible = false;
         }
      }
      
      public function set data(param1:CampaignArmy) : void
      {
         removeEvents();
         _data = param1;
         initEvents();
         initView();
         __onlineStateHandler(null);
         __transeferWaitStateHandler(null);
      }
      
      public function get userId() : int
      {
         if(_data)
         {
            return _data.userId;
         }
         return -1;
      }
      
      public function get data() : CampaignArmy
      {
         return _data;
      }
      
      override public function get tipData() : Object
      {
         var _loc1_:MultipleDictionaryInfo = new MultipleDictionaryInfo();
         var _loc2_:String = LanguageMgr.GetTranslation("map.campaign.view.ui.TeamItemView.ArmyNumberTip");
         _loc1_.addItem(_loc2_ + ":",String(_data.countAllArmyPawnNmber()));
         var _loc3_:String = LanguageMgr.GetTranslation("public.playerInfo.ap");
         _loc1_.addItem(_loc3_ + ":",String(_data.combatPower));
         return _loc1_;
      }
      
      override public function get height() : Number
      {
         return _bgAsset.height;
      }
      
      override public function get width() : Number
      {
         return _bgAsset.width;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_bgAsset)
         {
            _bgAsset.stop();
            if(_bgAsset.parent)
            {
               _bgAsset.parent.removeChild(_bgAsset);
            }
         }
         _bgAsset = null;
         ObjectUtils.disposeObject(_armyName);
         ObjectUtils.disposeObject(_levelTxt);
         ObjectUtils.disposeObject(_playerIcon);
         ObjectUtils.disposeObject(_transeferMask);
         _armyName = null;
         _levelTxt = null;
         _playerIcon = null;
         _filter = null;
         _data = null;
         _transeferMask = null;
         if(_jobImg)
         {
            _jobImg.dispose();
         }
         _jobImg = null;
         if(_captainMask)
         {
            _captainMask.dispose();
         }
         _captainMask = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

