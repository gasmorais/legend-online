package map.internals.view.physics
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import manager.LanguageMgr;
   import map.internals.data.BaseCastle;
   import map.internals.data.MapPhysics;
   import map.outercity.manager.OuterCityManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MultipleDictionaryInfo;
   
   public class PhysicsCastleView extends MapPhysicsAttackingBase
   {
      
      private var _defenceView:CastleDefenceView;
      
      private var _attackCastleMovie:MovieClip;
      
      public function PhysicsCastleView()
      {
         super();
         addEvent();
         _defenceView = new CastleDefenceView();
      }
      
      override protected function initView() : void
      {
         _defenceView.data = castleInfo;
         layouCallBack();
      }
      
      override protected function layouCallBack() : void
      {
         if(isRemoveStage)
         {
            return;
         }
         _defenceView.x = -_defenceView.width / 2;
         _defenceView.y = moviePos.y - _defenceView.height;
         if(_isPlaying)
         {
            addChild(_defenceView);
         }
      }
      
      override protected function setFireView() : void
      {
         super.setFireView();
         if(!_attackCastleMovie)
         {
            _attackCastleMovie = ComponentFactory.Instance.creatCustomObject("asset.outercity.AttackingAsset3");
         }
         addChild(_attackCastleMovie);
      }
      
      override protected function setNomalView() : void
      {
         super.setNomalView();
         if(_attackCastleMovie)
         {
            _attackCastleMovie.stop();
            if(_attackCastleMovie.parent)
            {
               _attackCastleMovie.parent.removeChild(_attackCastleMovie);
            }
         }
      }
      
      private function addEvent() : void
      {
      }
      
      override public function dispose() : void
      {
         if(castleInfo)
         {
            castleInfo.nodeView = null;
         }
         OuterCityManager.instance.model.addCasetInfoToPool(castleInfo);
         if(_defenceView)
         {
            _defenceView.dispose();
         }
         _defenceView = null;
         if(_attackCastleMovie)
         {
            _attackCastleMovie.stop();
            if(_attackCastleMovie.parent)
            {
               _attackCastleMovie.parent.removeChild(_attackCastleMovie);
            }
         }
         _attackCastleMovie = null;
         super.dispose();
      }
      
      override public function get tipData() : Object
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc6_:String = null;
         var _loc4_:BaseCastle = info as BaseCastle;
         var _loc3_:String = _loc4_.info.names + "(" + _loc4_.convertX + "," + _loc4_.convertY + ")";
         var _loc5_:MultipleDictionaryInfo = new MultipleDictionaryInfo();
         _loc5_.addItem(_loc3_,null);
         if(_loc4_.info.occupyPlayerId != 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("map.internals.view.displaye.PhysicsCastleView.addItem");
            _loc5_.addItem(_loc1_,_loc4_.info.names);
            _loc2_ = _loc4_.info.occupyLeagueName;
            if(_loc2_ == "")
            {
               _loc1_ = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.consortiaName");
               _loc2_ = _loc1_;
            }
            _loc1_ = LanguageMgr.GetTranslation("public.consortia");
            _loc5_.addItem(_loc1_,_loc2_);
            _loc6_ = _loc4_.info.grade + "";
            _loc1_ = LanguageMgr.GetTranslation("public.grade");
            _loc5_.addItem(_loc1_,_loc6_);
         }
         return _loc5_;
      }
      
      protected function get castleInfo() : BaseCastle
      {
         return info as BaseCastle;
      }
      
      public function get nodeInfo() : MapPhysics
      {
         return info;
      }
      
      public function get nameDefence() : CastleDefenceView
      {
         return _defenceView;
      }
      
      override protected function get resourcesPath() : String
      {
         return PathManager.solveMapPhysicsBySonType(castleInfo.sonType);
      }
      
      public function get isSelfCastle() : Boolean
      {
         if(castleInfo)
         {
            return castleInfo.info.occupyPlayerId == PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         }
         return false;
      }
      
      override public function set isPlaying(param1:Boolean) : void
      {
         super.isPlaying = param1;
         if(param1)
         {
            if(_defenceView)
            {
               addChild(_defenceView);
            }
         }
         else if(_defenceView && _defenceView.parent)
         {
            _defenceView.parent.removeChild(_defenceView);
         }
      }
   }
}

