package battle.view
{
   import battle.BattleManager;
   import battle.chat.BattleChatController;
   import battle.chat.BattleChatPopView;
   import battle.data.BattleMapData;
   import battle.events.BattleEvent;
   import battle.utils.BattleUtils;
   import battle.utils.Helpers;
   import battle.view.map.BattleMapView;
   import battle.view.roles.CreateDamageNumViewHelper;
   import battle.view.roles.PawnRoleView;
   import battle.view.roles.RoleViewBase;
   import battle.view.ui.BattleGoddessMovieView;
   import battle.view.ui.BattleUIView;
   import battle.view.ui.RedScreenEffect;
   import chat.datas.ChatData;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.filters.BlurFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import map.campaign.CampaignManager;
   import yishi.datas.BattleModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.WorldBossHelper;
   
   public class BattleView extends Sprite implements Disposeable
   {
      
      public static var CAMERA_Y:int = 480;
      
      public static const CAMERA_X:int = 650;
      
      private var _model:BattleModel;
      
      private var _sceneWidth:int = Helpers.limitRange(StageReferance.stage.stageWidth,1000,1500);
      
      private var _sceneHeight:int = Helpers.limitRange(StageReferance.stage.stageHeight,600,900);
      
      private var _battleUI:BattleUIView;
      
      private var _chatPop:BattleChatPopView;
      
      private var _map:BattleMapView;
      
      private var _profoundLayer:Sprite;
      
      private var _bitmap_background:Bitmap;
      
      private var _redScreenEffect:RedScreenEffect;
      
      private var _goddessMovieView:BattleGoddessMovieView;
      
      public function BattleView(param1:BattleModel)
      {
         _model = param1;
         super();
      }
      
      public function init() : void
      {
         BattleManager.getInstance().battleScene = this;
         _bitmap_background = new Bitmap();
         addChild(_bitmap_background);
         _map = new BattleMapView(_model);
         buildMap();
         addChild(_map);
         _profoundLayer = new Sprite();
         _profoundLayer.mouseChildren = _profoundLayer.mouseEnabled = false;
         addChild(_profoundLayer);
         _battleUI = new BattleUIView();
         addChild(_battleUI);
         BattleManager.getInstance().battleUIView = _battleUI;
         _map.cameraY = CAMERA_Y;
         _map.cameraX = 650;
         BattleManager.getInstance().battleMap = _map;
         _redScreenEffect = new RedScreenEffect();
         addChild(_redScreenEffect);
         initRole();
         addEvent();
         LayerManager.Instance.getLayerByType(4).visible = false;
         __onResize(null);
         BattleChatController.getInstance().start();
      }
      
      private function __onResize(param1:Event) : void
      {
         _sceneWidth = Helpers.limitRange(StageReferance.stage.stageWidth,1000,1500);
         _sceneHeight = Helpers.limitRange(StageReferance.stage.stageHeight,600,900);
         scrollRect = new Rectangle(0,0,_sceneWidth,_sceneHeight);
         _map.sceneWidth = _sceneWidth;
         _map.sceneHeight = _sceneHeight;
         CAMERA_Y = 900 - _sceneHeight * 0.5;
         _map.cameraY = CAMERA_Y;
         if(_chatPop)
         {
            _chatPop.x = 0;
            _chatPop.y = _sceneHeight - _chatPop.displayHeight;
         }
         if(_redScreenEffect)
         {
            _redScreenEffect.resize(_sceneWidth,_sceneHeight);
         }
      }
      
      public function update() : void
      {
         if(_map)
         {
            _map.update();
         }
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("BattleModelNotic.ADD_ROLE",__modelAddRole);
         NotificationManager.instance.addEventListener("REFRESH_BACK_BITMAP",__refreshBackGroundBitmap);
         NotificationManager.instance.addEventListener("shakeMapComplete",onShakeMapComplete);
         NotificationManager.instance.addEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
         StageReferance.stage.addEventListener("resize",__onResize,false,1);
         NotificationManager.instance.addEventListener("GODDESS_GUARD_SKILL",__goddessSkillHandler);
      }
      
      private function onShakeMapComplete(param1:BattleEvent) : void
      {
         if(_map.cameraY != CAMERA_Y)
         {
            __onResize(null);
         }
      }
      
      private function __playerChatHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:ChatData = param1.data as ChatData;
         if(_loc3_.channel != 6)
         {
            return;
         }
         var _loc5_:int = int(_loc3_.uid);
         var _loc4_:HeroRoleInfo = BattleManager.getInstance().battleModel.getHeroRoleByUserId(_loc5_);
         if(_loc4_ && _loc4_.side == BattleManager.getInstance().battleModel.selfHero.side)
         {
            _loc2_ = {};
            _loc2_["id"] = _loc4_.heroInfo.headId;
            _loc2_["data"] = _loc3_;
            if(_chatPop)
            {
               _chatPop.dispose();
               _chatPop = null;
            }
            if(!_chatPop && needShowChatPop)
            {
               _chatPop = new BattleChatPopView(__chatBackCall);
               _chatPop.data = _loc2_;
               _chatPop.x = 0;
               _chatPop.y = _sceneHeight - _chatPop.displayHeight - 130;
               addChild(_chatPop);
            }
         }
      }
      
      private function get needShowChatPop() : Boolean
      {
         if(CampaignManager.instance.mapModel)
         {
            return WorldBossHelper.checkNeedShowChatPop(CampaignManager.instance.mapModel.mapId);
         }
         return true;
      }
      
      private function __chatBackCall() : void
      {
         _chatPop = null;
      }
      
      private function __modelAddRole(param1:NotificationEvent) : void
      {
         var _loc2_:RoleInfo = RoleInfo(param1.data.oldInfo);
         if(_loc2_)
         {
            _map.removeRole(_loc2_.livingId);
         }
         var _loc3_:RoleInfo = RoleInfo(param1.data.newInfo);
         if(_loc3_)
         {
            addRole(_loc3_);
         }
      }
      
      private function buildMap() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = int(BattleManager.getInstance().battleModel.mapId);
         _loc1_ = int(TempleteManager.instance.mapTemplateCate.getTemplateByID(_loc2_).BattleGround);
         var _loc3_:BattleMapData = new BattleMapData();
         _map.changeMap(_loc3_);
      }
      
      private function initRole() : void
      {
         var _loc1_:Dictionary = null;
         _loc1_ = _model.armyInfoLeft.getHeros;
         initRoles(_loc1_);
         _loc1_ = _model.armyInfoLeft.getPawns;
         initRoles(_loc1_);
         _loc1_ = _model.armyInfoLeft.getPets;
         initRoles(_loc1_);
         _loc1_ = _model.armyInfoLeft.getGoddess;
         initRoles(_loc1_);
         _loc1_ = _model.armyInfoLeft.getMonster;
         initRoles(_loc1_);
         _loc1_ = _model.armyInfoRight.getHeros;
         initRoles(_loc1_);
         _loc1_ = _model.armyInfoRight.getPawns;
         initRoles(_loc1_);
         _loc1_ = _model.armyInfoRight.getPets;
         initRoles(_loc1_);
         _loc1_ = _model.armyInfoRight.getGoddess;
         initRoles(_loc1_);
         _loc1_ = _model.armyInfoRight.getMonster;
         initRoles(_loc1_);
      }
      
      private function initRoles(param1:Dictionary) : void
      {
         var _loc2_:Point = null;
         for each(var _loc3_:RoleInfo in param1)
         {
            _loc2_ = BattleUtils.rolePointByPos(_loc3_.pos,_loc3_.face);
            _loc3_.initPos(_loc2_);
            addRole(_loc3_);
         }
      }
      
      public function addRole(param1:RoleInfo) : void
      {
         var _loc2_:RoleViewBase = null;
         if(param1.needShow)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 295 || BattleManager.getInstance().battleModel.battleType == 3898)
         {
            if(param1.bloodA <= 0)
            {
               return;
            }
         }
         _loc2_ = param1.view;
         param1.defaultAction = "Stand";
         addRoleView(_loc2_);
         if(param1 is HeroRoleInfo && (param1 as HeroRoleInfo).type != 3 && checkBattleType())
         {
            addTeamStrip(param1 as HeroRoleInfo);
         }
         if(_loc2_ is PawnRoleView && !param1.isLiving)
         {
            param1.isLiving = false;
         }
      }
      
      private function addTeamStrip(param1:HeroRoleInfo) : void
      {
         if(param1 == null || _battleUI == null)
         {
            return;
         }
         _battleUI.addTeamStrip(param1);
      }
      
      private function checkBattleType() : Boolean
      {
         if(!_model)
         {
            return false;
         }
         switch(_model.battleType)
         {
            case 16:
            case 19:
            case 32:
            case 35:
            case 36:
            case 38:
            case 306:
            case 307:
               break;
            default:
               return true;
         }
         return false;
      }
      
      private function addRoleView(param1:RoleViewBase) : void
      {
         param1.info.map = _map;
         _map.addRole(param1);
      }
      
      public function playRedScreen() : void
      {
         _redScreenEffect.play();
      }
      
      protected function __refreshBackGroundBitmap(param1:Event) : void
      {
         if(BattleManager.getInstance().mainViewContainer.view)
         {
            if(_bitmap_background.bitmapData)
            {
               _bitmap_background.bitmapData.dispose();
            }
            _bitmap_background.bitmapData = drawDisplayObject(BattleManager.getInstance().mainViewContainer.view);
            _bitmap_background.bitmapData.applyFilter(_bitmap_background.bitmapData,new Rectangle(0,0,_bitmap_background.bitmapData.width,_bitmap_background.bitmapData.height),new Point(),new BlurFilter(10,10,1));
            _bitmap_background.x = -1;
            _bitmap_background.y = -1;
         }
      }
      
      public function drawDisplayObject(param1:DisplayObject = null) : BitmapData
      {
         var _loc3_:Rectangle = null;
         var _loc4_:BitmapData = null;
         var _loc5_:Matrix = null;
         var _loc2_:Rectangle = param1.getBounds(param1);
         if(param1 is Stage || _loc2_.width != 0 && _loc2_.height != 0)
         {
            _loc3_ = new Rectangle(0,0,Math.abs(_loc2_.width),Math.abs(_loc2_.height));
            _loc3_.width = _loc3_.width > 2880 ? 2880 : _loc3_.width;
            _loc3_.height = _loc3_.height > 2880 ? 2880 : _loc3_.height;
            _loc4_ = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _loc5_ = new Matrix();
            _loc5_.translate(-_loc2_.x,-_loc2_.y);
            _loc4_.draw(param1,_loc5_);
            return _loc4_;
         }
         return null;
      }
      
      private function __goddessSkillHandler(param1:NotificationEvent) : void
      {
         if(!VersionSwitch.GODDESS_OPEN)
         {
            return;
         }
         var _loc2_:Array = param1.data as Array;
         if(_loc2_.length > 0)
         {
            if(!_goddessMovieView)
            {
               _goddessMovieView = new BattleGoddessMovieView();
            }
            _goddessMovieView.setViewData(_loc2_);
            addChild(_goddessMovieView);
         }
      }
      
      public function get sceneWidth() : int
      {
         return _sceneWidth;
      }
      
      public function get sceneHeight() : int
      {
         return _sceneHeight;
      }
      
      public function getProfoundLayer() : Sprite
      {
         return _profoundLayer;
      }
      
      public function dispose() : void
      {
         BattleChatController.getInstance().dispose();
         LayerManager.Instance.getLayerByType(4).visible = true;
         NotificationManager.instance.removeEventListener("BattleModelNotic.ADD_ROLE",__modelAddRole);
         NotificationManager.instance.removeEventListener("REFRESH_BACK_BITMAP",__refreshBackGroundBitmap);
         NotificationManager.instance.removeEventListener("shakeMapComplete",onShakeMapComplete);
         NotificationManager.instance.removeEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
         StageReferance.stage.removeEventListener("resize",__onResize);
         NotificationManager.instance.removeEventListener("GODDESS_GUARD_SKILL",__goddessSkillHandler);
         ObjectUtils.disposeObject(_chatPop);
         _chatPop = null;
         ObjectUtils.disposeObject(_redScreenEffect);
         _redScreenEffect = null;
         ObjectUtils.disposeObject(_map);
         _map = null;
         ObjectUtils.disposeObject(_battleUI);
         _battleUI = null;
         ObjectUtils.disposeObject(_goddessMovieView);
         _goddessMovieView = null;
         ObjectUtils.disposeAllChildren(_profoundLayer);
         _model = null;
         BattleManager.getInstance().battleMap = null;
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_bitmap_background);
         CreateDamageNumViewHelper.ins().dispose();
      }
   }
}

