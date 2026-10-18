package map.campaign.action
{
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import events.ArmyEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.skill.MapBuffHurtData;
   import map.campaign.data.skill.MapSkillHurtData;
   import map.campaign.helper.gvgcross.GvgCrossResourceManager;
   import map.campaign.view.CampaignMapView;
   import map.campaign.view.physics.ActiveVehicleNpcAvater;
   import map.campaign.view.skill.MapHurtView;
   import map.internals.constant.MapGlobal;
   import map.internals.data.CampaignNode;
   import map.internals.data.PhysicsEvent;
   import yishi.actions.map.MapBaseAction;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.view.tools.SimpleMovie;
   
   public class ActiveVehicleNpcDannyAction extends MapBaseAction
   {
      
      private var _hurtData:Object;
      
      private var _duration:int;
      
      private var _startTime:int = 0;
      
      private var _buffHurtData:MapBuffHurtData;
      
      private var _skillHurtData:MapSkillHurtData;
      
      private var _buffEffect:MovieClip;
      
      private var _tankBody:Sprite;
      
      private var _nodeView:ActiveVehicleNpcAvater;
      
      private var _nodeInfo:CampaignNode;
      
      private var _mapView:CampaignMapView;
      
      private var _controller:CampaignMapController;
      
      private var _effectLayer:Sprite;
      
      private var _colorDatas:Object = {
         "normal":{
            "rm":1,
            "gm":1,
            "bm":1,
            "am":1,
            "ro":0,
            "go":0,
            "bo":0,
            "ao":0
         },
         "slow":{
            "rm":1,
            "gm":1,
            "bm":1,
            "am":1,
            "ro":0,
            "go":42,
            "bo":57,
            "ao":0
         },
         "poisoning":{
            "rm":1,
            "gm":1,
            "bm":1,
            "am":1,
            "ro":0,
            "go":51,
            "bo":0,
            "ao":0
         }
      };
      
      public function ActiveVehicleNpcDannyAction(param1:CampaignNode, param2:Object, param3:int = 0)
      {
         super();
         _mapView = CampaignManager.instance.mapView;
         _controller = CampaignManager.instance.controller;
         _nodeInfo = param1;
         if(_mapView)
         {
            _effectLayer = _mapView.effectLayer;
         }
         if(_controller)
         {
            _nodeView = param1.nodeView as ActiveVehicleNpcAvater;
         }
         _hurtData = param2;
         _duration = param3;
         if(_hurtData is MapBuffHurtData)
         {
            _buffHurtData = _hurtData as MapBuffHurtData;
         }
         else if(_hurtData is MapSkillHurtData)
         {
            _skillHurtData = _hurtData as MapSkillHurtData;
         }
         if(_buffHurtData)
         {
            initDuration();
         }
      }
      
      override public function dispose() : void
      {
         if(_nodeInfo && _nodeInfo.info)
         {
            _nodeInfo.info.removeEventListener("UP_STATE",__updateNodeStateHandler);
         }
         if(_nodeInfo)
         {
            _nodeInfo.removeEventListener("REMOVE_BUFF",__removeBuffHandler);
            _nodeInfo.removeEventListener("UPDATE_BUFF",__updateBuffHandler);
            _nodeInfo.removeEventListener("UPDATE_CUR_HP",__updateNodeHpHandler);
         }
         ObjectUtils.disposeObject(_buffEffect);
         _buffEffect = null;
         checkDamageEffect();
         _tankBody = null;
         _hurtData = null;
         _mapView = null;
         _controller = null;
         _nodeInfo = null;
         _nodeView = null;
         super.dispose();
      }
      
      override public function prepare() : void
      {
         var _loc1_:MapHurtView = null;
         _startTime = getTimer();
         if(_nodeView)
         {
            if(_skillHurtData)
            {
               _loc1_ = new MapHurtView(_skillHurtData.effectValue,_skillHurtData.effectType);
               _loc1_.y = _nodeView.getHitPoint().y - _nodeView.y - 20;
               _loc1_.x += _nodeView.x;
               _loc1_.y += _nodeView.y;
               _effectLayer.addChild(_loc1_);
               finished = true;
            }
            else if(_buffHurtData)
            {
               addBuffEffect(_nodeView);
               _nodeInfo.info.addEventListener("UP_STATE",__updateNodeStateHandler);
               _nodeInfo.addEventListener("UPDATE_CUR_HP",__updateNodeHpHandler);
               _nodeInfo.addEventListener("REMOVE_BUFF",__removeBuffHandler);
               _nodeInfo.addEventListener("UPDATE_BUFF",__updateBuffHandler);
            }
         }
      }
      
      private function __updateNodeHpHandler(param1:PhysicsEvent) : void
      {
         var _loc2_:MapHurtView = null;
         if(!checkDied(_nodeInfo.info.state) && _nodeInfo.curHp > 0 && _nodeView)
         {
            if(_buffHurtData && _buffHurtData.buffTemplate.EffectType == 8 && _buffHurtData.buffTemplate.EffectValue < 0)
            {
               _loc2_ = new MapHurtView(-_buffHurtData.buffTemplate.EffectValue,0);
               _loc2_.y = _nodeView.getHitPoint().y - _nodeView.y - 20;
               _loc2_.x += _nodeView.x;
               _loc2_.y += _nodeView.y;
               _effectLayer.addChild(_loc2_);
            }
         }
      }
      
      private function __updateNodeStateHandler(param1:PhysicsEvent) : void
      {
         if(checkDied(_nodeInfo.info.state))
         {
            finished = true;
         }
      }
      
      private function __removeBuffHandler(param1:ArmyEvent) : void
      {
         var _loc2_:MapBuffHurtData = null;
         if(_buffHurtData)
         {
            _loc2_ = param1.data as MapBuffHurtData;
            if(_loc2_.buffId == _buffHurtData.buffId)
            {
               finished = true;
            }
         }
      }
      
      private function __updateBuffHandler(param1:ArmyEvent) : void
      {
         var _loc2_:MapBuffHurtData = null;
         if(_buffHurtData)
         {
            _loc2_ = param1.data as MapBuffHurtData;
            if(_loc2_.buffId == _buffHurtData.buffId)
            {
               _startTime = getTimer();
               initDuration();
            }
         }
      }
      
      private function initDuration() : void
      {
         if(MapBuffHurtData(_buffHurtData).buffTemplate.Duration != 0)
         {
            _buffHurtData.leftTime = MapBuffHurtData(_buffHurtData).buffTemplate.Duration / 1000;
         }
         _duration = _buffHurtData.leftTime;
      }
      
      private function addBuffEffect(param1:ActiveVehicleNpcAvater) : void
      {
         var _loc2_:Point = null;
         _buffEffect = GvgCrossResourceManager.instance.createBuffEffect(_buffHurtData.buffId);
         if(!_buffEffect)
         {
            return;
         }
         var _loc3_:VehicleSkillBuffTemplate = _buffHurtData.buffTemplate;
         if(_loc3_.Duration == 0)
         {
            param1.effectLayer.addChild(new SimpleMovie(_buffEffect));
         }
         else if(StringUtils.endsWith(_loc3_.LastEffect,"_a"))
         {
            param1.effectLayer.addChild(_buffEffect);
            _loc2_ = param1.getHeadPos();
            _buffEffect.y = _loc2_.y;
         }
         else
         {
            param1.effectLayer.addChild(_buffEffect);
         }
      }
      
      override public function update() : void
      {
         if(_buffHurtData)
         {
            handerBuff();
         }
      }
      
      private function handerBuff() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = getTimer() - _startTime;
         if(MapBuffHurtData(_buffHurtData).buffTemplate.Duration != -1)
         {
            _buffHurtData.leftTime = _duration - int(_loc1_ / 1000);
            if(_buffHurtData.leftTime <= 0)
            {
               _buffHurtData.leftTime = 0;
               finished = true;
            }
            if(checkDied(_nodeInfo.info.state))
            {
               finished = true;
            }
            if(finished)
            {
               _loc2_ = int(_nodeInfo.buffList.indexOf(_buffHurtData));
               if(_loc2_ != -1)
               {
                  _nodeInfo.buffList.splice(_loc2_,1);
                  _nodeInfo.removeEventListener("REMOVE_BUFF",__removeBuffHandler);
                  _nodeInfo.dispatchEvent(new ArmyEvent("REMOVE_BUFF",_hurtData));
               }
            }
         }
         checkDamageEffect();
      }
      
      private function checkDied(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(param1)
         {
            case 0:
            case 8:
            case 9:
               _loc2_ = true;
               break;
            default:
               _loc2_ = false;
         }
         return _loc2_;
      }
      
      private function checkDamageEffect() : void
      {
         var _loc1_:MapBuffHurtData = null;
         var _loc2_:VehicleSkillBuffTemplate = null;
         if(_hurtData is MapBuffHurtData)
         {
            _loc1_ = _hurtData as MapBuffHurtData;
            _loc2_ = _loc1_.buffTemplate;
            switch(_loc2_.EffectType)
            {
               case MapGlobal.SPEED_CHANGE:
                  speedChange();
                  break;
               case MapGlobal.HP_CHANGE:
                  poisoning();
                  break;
               case MapGlobal.STUN:
                  stun();
            }
         }
      }
      
      private function speedChange() : void
      {
         var _loc3_:Array = [];
         for each(var _loc4_:MapBuffHurtData in _nodeInfo.buffList)
         {
            if(_loc4_.buffTemplate.EffectType == MapGlobal.SPEED_CHANGE && _loc3_.indexOf(_loc4_.buffId) == -1)
            {
               _loc3_.push(_loc4_.buffTemplate);
            }
         }
         var _loc5_:int = int(_nodeView.activeVehicleTempInfo.Speed);
         var _loc1_:int = 0;
         for each(var _loc2_:VehicleSkillBuffTemplate in _loc3_)
         {
            if(_loc2_.EffectValue != 0)
            {
               _loc1_ += _loc2_.EffectValue;
            }
            else if(_loc2_.EffectPercent != 0)
            {
               _loc1_ += int(_loc5_ * _loc2_.EffectPercent / 100);
            }
         }
         if(_nodeView)
         {
            _nodeView.aiInfo.speed = _loc5_ + _loc1_;
            drawBuffEffect(_tankBody,"normal");
            _tankBody = _nodeView.body;
            if(_loc1_ >= 0)
            {
               drawBuffEffect(_tankBody,"normal");
            }
            else
            {
               drawBuffEffect(_tankBody,"slow");
            }
         }
      }
      
      private function poisoning() : void
      {
         var _loc1_:Array = [];
         for each(var _loc2_:MapBuffHurtData in _nodeInfo.buffList)
         {
            if(_loc2_.buffTemplate.EffectType == MapGlobal.HP_CHANGE && _loc1_.indexOf(_loc2_.buffId) == -1)
            {
               _loc1_.push(_loc2_.buffTemplate);
            }
         }
         if(_nodeView)
         {
            drawBuffEffect(_tankBody,"normal");
            _tankBody = _nodeView.body;
            if(_loc1_.length <= 0)
            {
               drawBuffEffect(_tankBody,"normal");
            }
            else
            {
               drawBuffEffect(_tankBody,"poisoning");
            }
         }
      }
      
      private function stun() : void
      {
         _nodeView.aiInfo.pathInfo = [];
         if(finished)
         {
            _nodeInfo.isStun = false;
         }
         else
         {
            _nodeInfo.isStun = true;
         }
      }
      
      private function drawBuffEffect(param1:Sprite, param2:String) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc3_:ColorTransform = new ColorTransform();
         checkColor(_loc3_,param2);
         param1.transform.colorTransform = _loc3_;
      }
      
      private function checkColor(param1:ColorTransform, param2:String) : void
      {
         param1.redMultiplier = _colorDatas[param2].rm;
         param1.greenMultiplier = _colorDatas[param2].gm;
         param1.blueMultiplier = _colorDatas[param2].bm;
         param1.alphaMultiplier = _colorDatas[param2].am;
         param1.redOffset = _colorDatas[param2].ro;
         param1.greenOffset = _colorDatas[param2].go;
         param1.blueOffset = _colorDatas[param2].bo;
         param1.alphaOffset = _colorDatas[param2].ao;
      }
   }
}

