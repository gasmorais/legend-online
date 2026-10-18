package battle.view.ui
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import battle.view.BattleView;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.RoleEvent;
   import yishi.manager.NotificationManager;
   
   public class MutilBossShowView extends Sprite implements Disposeable
   {
      
      private var _worldBossRoleInfo:HeroRoleInfo;
      
      private var _offsetXList:Vector.<int>;
      
      private var _isInitedData:Boolean = false;
      
      private var _roleInfoGroupViewList:Vector.<RoleInfoGroupView>;
      
      private var _roleTempIdToRoleInfoViewDic:Dictionary;
      
      private const VIEW_WIDTH:uint = 966;
      
      private const HEIGHT_GAP:uint = 10;
      
      public function MutilBossShowView(param1:Vector.<String>, param2:Vector.<int> = null)
      {
         super();
         _offsetXList = param2;
         _roleInfoGroupViewList = new Vector.<RoleInfoGroupView>();
         _roleTempIdToRoleInfoViewDic = new Dictionary();
         initView(param1);
         addEvent();
         doLayout();
      }
      
      private function initView(param1:Vector.<String>) : void
      {
         var _loc5_:RoleInfoGroupView = null;
         var _loc4_:* = 0;
         var _loc3_:uint = param1.length;
         var _loc2_:uint = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new RoleInfoGroupView(param1[_loc4_]);
            _roleInfoGroupViewList.push(_loc5_);
            _loc5_.y = _loc2_ + 10 * _loc4_;
            _loc2_ += _loc5_.resourceWidthHeight[1];
            addChild(_loc5_);
            if(_offsetXList != null)
            {
               _loc5_.x += _offsetXList[_loc4_];
            }
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("enterFrame",__enterFrame);
         StageReferance.stage.addEventListener("resize",stageResizeHandler);
         NotificationManager.instance.addEventListener("BATTLE_RESULT",battleResultHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__enterFrame);
         StageReferance.stage.removeEventListener("resize",stageResizeHandler);
         BattleManager.getInstance().battleModel.removeEventListener("reduceWorldBossBlood",onReduceWorldBossBlood);
         NotificationManager.instance.removeEventListener("BATTLE_RESULT",battleResultHandler);
      }
      
      private function stageResizeHandler(param1:Event) : void
      {
         doLayout();
      }
      
      private function doLayout() : void
      {
         var _loc1_:BattleView = null;
         var _loc2_:Number = NaN;
         if(BattleManager.getInstance().mainViewContainer != null && BattleManager.getInstance().mainViewContainer.view != null)
         {
            _loc1_ = BattleManager.getInstance().mainViewContainer.view;
            _loc2_ = _loc1_.sceneWidth / 1500;
            for each(var _loc3_:RoleInfoGroupView in _roleInfoGroupViewList)
            {
               scaleX = scaleY = _loc2_;
            }
            x = _loc1_.sceneWidth - 966 * _loc2_;
         }
      }
      
      private function __enterFrame(param1:Event) : void
      {
         var _loc2_:Number = Number(BattleManager.getInstance().battleModel.armyInfoRight.getLeftHp());
         if(_loc2_ <= 0)
         {
            BattleManager.getInstance().battleModel.isOver = true;
            NotificationManager.instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
      }
      
      public function getRoleInfoByTempId(param1:uint) : RoleInfo
      {
         var _loc2_:RoleInfo = null;
         var _loc3_:RoleInfoGroupView = _roleTempIdToRoleInfoViewDic[param1] as RoleInfoGroupView;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.curRoleInfo;
         }
         return _loc2_;
      }
      
      public function playDamageNumEffect(param1:uint, param2:Number) : void
      {
         var _loc3_:RoleInfoGroupView = _roleTempIdToRoleInfoViewDic[param1] as RoleInfoGroupView;
         if(_loc3_ != null)
         {
            _loc3_.playDamageEffect(param2);
         }
      }
      
      public function resetRoleData(... rest) : void
      {
         var _loc2_:Boolean = false;
         var _loc5_:RoleInfoGroupView = null;
         var _loc3_:Vector.<uint> = new Vector.<uint>();
         for each(var _loc4_:HeroRoleInfo in rest)
         {
            if(_loc4_ != null)
            {
               _loc5_ = _roleTempIdToRoleInfoViewDic[_loc4_.templateId] as RoleInfoGroupView;
               _loc5_.updateUIByHeroInfo(_loc4_,_loc5_.needShowBuff);
               _loc3_.push(_loc5_.curRoleInfo.templateId);
            }
         }
         playRefreshEffect(_loc3_);
      }
      
      public function setRoleData(param1:Vector.<HeroRoleInfo>, ... rest) : void
      {
         var _loc7_:HeroRoleInfo = null;
         var _loc8_:RoleInfoGroupView = null;
         var _loc3_:Boolean = false;
         var _loc6_:* = 0;
         if(!_isInitedData)
         {
            _isInitedData = true;
         }
         deleteHeroRole();
         var _loc4_:uint = _roleInfoGroupViewList.length;
         var _loc5_:Vector.<uint> = new Vector.<uint>();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc8_ = _roleInfoGroupViewList[_loc6_];
            if(_loc6_ < param1.length && param1[_loc6_] != null)
            {
               _loc8_.visible = true;
               _loc7_ = param1[_loc6_];
               _loc3_ = rest.indexOf(_loc7_) >= 0;
               _loc8_.updateUIByHeroInfo(_loc7_,_loc3_);
               _roleTempIdToRoleInfoViewDic[_loc7_.templateId] = _loc8_;
               _loc7_.addEventListener("bloodChange",roleBloodChangeHandler);
               _loc5_.push(_loc7_.templateId);
            }
            else
            {
               _loc8_.visible = false;
            }
            _loc6_++;
         }
         if(_isInitedData)
         {
            playRefreshEffect(_loc5_);
         }
      }
      
      private function deleteHeroRole() : void
      {
         var _loc1_:HeroRoleInfo = null;
         var _loc2_:RoleInfoGroupView = null;
         for(var _loc3_:Object in _roleTempIdToRoleInfoViewDic)
         {
            _loc2_ = _roleTempIdToRoleInfoViewDic[_loc3_] as RoleInfoGroupView;
            _loc1_ = _loc2_.curRoleInfo;
            _loc1_.removeEventListener("bloodChange",roleBloodChangeHandler);
            _roleTempIdToRoleInfoViewDic[_loc3_] = null;
            delete _roleTempIdToRoleInfoViewDic[_loc3_];
         }
      }
      
      private function playRefreshEffect(param1:Vector.<uint>) : void
      {
         var _loc2_:RoleInfoGroupView = null;
         for each(var _loc3_:uint in param1)
         {
            _loc2_ = _roleTempIdToRoleInfoViewDic[_loc3_];
            if(_loc2_ != null)
            {
               _loc2_.playEnterEffect();
            }
         }
      }
      
      private function roleBloodChangeHandler(param1:RoleEvent) : void
      {
         var _loc3_:HeroRoleInfo = param1.target as HeroRoleInfo;
         var _loc2_:RoleInfoGroupView = _roleTempIdToRoleInfoViewDic[_loc3_.templateId];
         if(_loc2_ != null)
         {
            _loc2_.setCurBlood(_loc3_.bloodA);
         }
      }
      
      public function refreshTurn() : void
      {
         for each(var _loc1_:RoleInfoGroupView in _roleInfoGroupViewList)
         {
            _loc1_.refreshBuff();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         deleteHeroRole();
         for each(var _loc1_:RoleInfoGroupView in _roleInfoGroupViewList)
         {
            _loc1_.dispose();
         }
         ObjectUtils.disposeAllChildren(this);
         _roleTempIdToRoleInfoViewDic = null;
         if(_roleInfoGroupViewList)
         {
            _roleInfoGroupViewList.length = 0;
         }
         _roleInfoGroupViewList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set worldBossRoleInfo(param1:HeroRoleInfo) : void
      {
         _worldBossRoleInfo = param1;
         var _loc2_:BattleModel = BattleManager.getInstance().battleModel;
         if(_worldBossRoleInfo != null)
         {
            if(!_loc2_.hasEventListener("reduceWorldBossBlood"))
            {
               _loc2_.addEventListener("reduceWorldBossBlood",onReduceWorldBossBlood);
            }
         }
         else
         {
            _loc2_.removeEventListener("reduceWorldBossBlood",onReduceWorldBossBlood);
         }
      }
      
      private function onReduceWorldBossBlood(param1:BattleEvent) : void
      {
         var _loc3_:RoleInfoGroupView = null;
         var _loc2_:Number = NaN;
         if(_worldBossRoleInfo != null)
         {
            _loc3_ = _roleTempIdToRoleInfoViewDic[_worldBossRoleInfo.templateId] as RoleInfoGroupView;
            if(_loc3_ != null)
            {
               _loc2_ = Number(param1.data);
               _loc3_.addCurBlood(_loc2_);
               _loc3_.playDamageEffect(_loc2_);
            }
         }
      }
      
      private function battleResultHandler(param1:NotificationEvent) : void
      {
         var _loc2_:RoleInfoGroupView = null;
         var _loc3_:Boolean = Boolean(param1.data);
         if(_worldBossRoleInfo != null && _loc3_)
         {
            _loc2_ = _roleTempIdToRoleInfoViewDic[_worldBossRoleInfo.templateId] as RoleInfoGroupView;
            if(_loc2_ != null)
            {
               _loc2_.setCurBlood(0);
            }
         }
      }
   }
}

import battle.view.buffer.BossBufferContainer;
import battle.view.ui.IHpStrip;
import battle.view.ui.top.BossInfoViewII;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.utils.ObjectUtils;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.Point;
import yishi.datas.objects.HeroRoleInfo;

class RoleInfoGroupView extends Sprite
{
   
   private static const BUFF_POS:Point = new Point(740,43);
   
   private var _needShowBuff:Boolean;
   
   private var _bossInfoResourceMc:MovieClip;
   
   private var _curRoleInfo:HeroRoleInfo;
   
   private var _bossInfoView:BossInfoViewII;
   
   private var _bossBuffView:BossBufferContainer;
   
   private var _resourceWidthHeight:Vector.<uint> = new Vector.<uint>();
   
   public function RoleInfoGroupView(param1:String)
   {
      super();
      var _loc2_:MovieClip = ComponentFactory.Instance.creatCustomObject(param1);
      _resourceWidthHeight.push(_loc2_.width,_loc2_.height);
      _bossInfoResourceMc = _loc2_;
      _bossInfoView = new BossInfoViewII(_bossInfoResourceMc,param1);
      _bossBuffView = new BossBufferContainer(null);
      addChild(_bossInfoView);
      addChild(_bossBuffView);
      _bossBuffView.x = BUFF_POS.x;
      _bossBuffView.y = BUFF_POS.y;
   }
   
   public function updateUIByHeroInfo(param1:HeroRoleInfo, param2:Boolean) : void
   {
      _needShowBuff = param2;
      _curRoleInfo = param1;
      _bossInfoView.updateUIByHeroInfo(param1,param1.totalBloodA,param1.bloodA);
      _bossBuffView.removeEvent();
      if(param2)
      {
         _bossBuffView.initEvent(param1);
      }
      _bossBuffView.reFreshBuffer(null);
      _bossBuffView.visible = param2;
   }
   
   public function playDamageEffect(param1:Number) : void
   {
      param1 = param1 < 0 ? -param1 : param1;
      _bossInfoView.playDamageNumEffect(param1);
   }
   
   public function addCurBlood(param1:Number) : void
   {
      var _loc2_:IHpStrip = _bossInfoView.hpView as IHpStrip;
      _loc2_.currentValue += param1;
   }
   
   public function setCurBlood(param1:uint) : void
   {
      (_bossInfoView.hpView as IHpStrip).currentValue = param1;
   }
   
   public function refreshBuff() : void
   {
      _bossBuffView.refreshTurn();
   }
   
   public function playEnterEffect() : void
   {
      _bossInfoView.bossInfoViewResouce.gotoAndPlay(1);
   }
   
   public function dispose() : void
   {
      if(_bossInfoView)
      {
         _bossInfoView.dispose();
      }
      _bossInfoView = null;
      if(_bossBuffView)
      {
         _bossBuffView.dispose();
      }
      _bossBuffView = null;
      if(_bossInfoResourceMc)
      {
         ObjectUtils.stopAllSubClips(_bossInfoResourceMc);
         ObjectUtils.disposeViolentMc(_bossInfoResourceMc);
      }
      _bossInfoResourceMc = null;
      if(parent)
      {
         parent.removeChild(this);
      }
   }
   
   public function get curRoleInfo() : HeroRoleInfo
   {
      return _curRoleInfo;
   }
   
   public function get needShowBuff() : Boolean
   {
      return _needShowBuff;
   }
   
   public function get resourceWidthHeight() : Vector.<uint>
   {
      return _resourceWidthHeight;
   }
}
