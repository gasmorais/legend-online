package map.campaign.view.ui.activevehicle
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import map.campaign.CampaignManager;
   import map.campaign.data.ActiveVehicleModel;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignEvent;
   import map.internals.event.OuterCityEvent;
   
   public class ActiveVehicleTeamView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _flag:ScaleFrameImage;
      
      private var _hideBtn:BaseButton;
      
      private var _isHide:Boolean;
      
      private var _itemList:Array;
      
      private var _rect:Shape;
      
      private var _sprite:Sprite;
      
      private var _teamTxt:Bitmap;
      
      private var _tween:TweenMax;
      
      private var _model:ActiveVehicleModel;
      
      public function ActiveVehicleTeamView()
      {
         super();
         _model = CampaignManager.instance.activeVehicleModel;
         initView();
         addEvent();
         update();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ActiveVehicleTeamItemView = null;
         _back = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.TeamBack");
         _teamTxt = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.TeamText");
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.HideBtn");
         _flag = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.teamFlag");
         _flag.x = 78;
         _flag.y = 2;
         _sprite = new Sprite();
         _sprite.x = 4;
         _sprite.y = 32;
         addChild(_back);
         addChild(_teamTxt);
         addChild(_hideBtn);
         addChild(_flag);
         addChild(_sprite);
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new ActiveVehicleTeamItemView();
            _sprite.addChild(_loc1_);
            _loc1_.y = _loc2_ * 67;
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _rect = new Shape();
         _rect.graphics.beginFill(0,0);
         _rect.graphics.drawRect(0,0,87,203);
         _rect.graphics.endFill();
         _rect.x = 4;
         _rect.y = 32;
         addChild(_rect);
         _hideBtn.scaleX = -1;
         _hideBtn.x = 6 + _hideBtn.displayWidth;
      }
      
      private function addEvent() : void
      {
         if(mapModel)
         {
            mapModel.addEventListener("addGarrison",__addPlayerHandler);
            mapModel.addEventListener("REMOVE_ARMY",__removePlayerHandler);
         }
         if(_model)
         {
            _model.addEventListener("ACTIVEVEHICLE_PLAYERSUPDATE",__updatePlayerList);
         }
         _hideBtn.addEventListener("click",__hideClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(mapModel)
         {
            mapModel.removeEventListener("addGarrison",__addPlayerHandler);
            mapModel.removeEventListener("REMOVE_ARMY",__removePlayerHandler);
         }
         if(_model)
         {
            _model.addEventListener("ACTIVEVEHICLE_PLAYERSUPDATE",__updatePlayerList);
         }
         if(_hideBtn)
         {
            _hideBtn.removeEventListener("click",__hideClickHandler);
         }
      }
      
      private function __updatePlayerList(param1:CampaignEvent) : void
      {
         update();
      }
      
      private function __addPlayerHandler(param1:OuterCityEvent) : void
      {
         update();
      }
      
      private function __removePlayerHandler(param1:OuterCityEvent) : void
      {
         for each(var _loc2_:ActiveVehicleTeamItemView in _itemList)
         {
            if(_loc2_.data == param1.data)
            {
               _loc2_.data = null;
            }
         }
         update();
      }
      
      private function __hideClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_tween)
         {
            _tween.kill();
            _tween = null;
         }
         if(_isHide)
         {
            _isHide = false;
            _hideBtn.scaleX = -1;
            _hideBtn.x = 6 + _hideBtn.displayWidth;
            _tween = TweenMax.to(_rect,0.3,{
               "height":203,
               "width":87,
               "onUpdate":onTween,
               "onComplete":onCompleteHander
            });
            _sprite.y = 32;
         }
         else
         {
            _isHide = true;
            _hideBtn.scaleX = 1;
            _hideBtn.x = 6;
            _tween = TweenMax.to(_rect,0.3,{
               "height":0,
               "width":0,
               "onUpdate":onTween
            });
         }
      }
      
      private function onTween() : void
      {
         _sprite.mask = _rect;
      }
      
      private function onCompleteHander() : void
      {
         _sprite.mask = null;
      }
      
      private function update() : void
      {
         var _loc3_:int = 0;
         var _loc2_:ActiveVehicleTeamItemView = null;
         if(!_model)
         {
            return;
         }
         if(mapModel && mapModel.selfMemberData && _flag)
         {
            _flag.setFrame(mapModel.selfMemberData.activeTeamId);
         }
         var _loc1_:Array = _model.getActiveTeamMembers();
         if(!_itemList)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc3_];
            _loc2_.data = _loc1_[_loc3_];
            _loc3_++;
         }
      }
      
      public function resize() : void
      {
         var _loc1_:int = int(StageReferance.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         this.x = 0;
         this.y = 300;
      }
      
      public function show() : void
      {
         resize();
         LayerManager.Instance.addToLayer(this,4,false,false,0,3);
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      override public function dispose() : void
      {
         if(_tween)
         {
            _tween.kill();
            _tween = null;
         }
         removeEvent();
         ObjectUtils.disposeObject(_flag);
         _flag = null;
         ObjectUtils.disposeAllChildren(_sprite);
         _sprite = null;
         _itemList = null;
         _teamTxt = null;
         _back = null;
         super.dispose();
      }
   }
}

