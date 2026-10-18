package map.internals.view.physics
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import map.internals.data.WildLand;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MultipleDictionaryInfo;
   
   public class PhysicsFieldView extends MapPhysicsAttackingBase
   {
      
      private var _owner:FilterFrameText;
      
      private var _name:FilterFrameText;
      
      public function PhysicsFieldView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         if(!_owner)
         {
            _owner = ComponentFactory.Instance.creatComponentByStylename("outercity.OutercityNameText");
         }
         _owner.x = -_owner.width / 2;
         var _loc1_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         if(_loc1_.userId == nodeInfo.info.occupyPlayerId)
         {
            _owner.setFrame(1);
         }
         else if(_loc1_.consortiaID > 0 && nodeInfo.info.occupyLeagueName != "")
         {
            if(nodeInfo.info.occupyLeagueName == _loc1_.consortiaName)
            {
               _owner.setFrame(3);
            }
            else
            {
               _owner.setFrame(2);
            }
         }
         else if(nodeInfo.info.occupyPlayerId > 0)
         {
            _owner.setFrame(2);
         }
         if(nodeInfo.info.occupyPlayerId != 0)
         {
            _owner.visible = true;
            _owner.text = nodeInfo.info.occupyPlayerName;
         }
         else
         {
            _owner.visible = false;
            _owner.text = "";
         }
         if(!_name)
         {
            _name = ComponentFactory.Instance.creatComponentByStylename("outercity.OutercityNameText");
         }
         _name.text = nodeInfo.tempInfo.MapPhysicsTempName + " " + LanguageMgr.GetTranslation("public.level2",nodeInfo.info.grade);
         _name.x = -_name.width / 2;
         _name.setFrame(4);
         layouCallBack();
      }
      
      override protected function layouCallBack() : void
      {
         if(isRemoveStage)
         {
            return;
         }
         _name.y = moviePos.y - _name.height + 5;
         _owner.y = moviePos.y - 40;
         if(_isPlaying)
         {
            addChild(_owner);
            addChild(_name);
         }
      }
      
      override protected function get resourcesPath() : String
      {
         return PathManager.solveMapPhysicsBySonType(nodeInfo.tempInfo.SonType);
      }
      
      override public function get tipData() : Object
      {
         var _loc5_:MultipleDictionaryInfo = new MultipleDictionaryInfo();
         _loc5_.addItem(nodeInfo.tempInfo.MapPhysicsTempName + " Nv." + nodeInfo.tempInfo.Grades,null);
         _loc5_.addItem(LanguageMgr.GetTranslation("map.PhysicsFieldView.info01"),nodeInfo.info.occupyPlayerName);
         _loc5_.addItem(LanguageMgr.GetTranslation("public.playerInfo.ap"),String(nodeInfo.fightCapaity));
         var _loc3_:Number = Number(nodeInfo.tempInfo.Property3 == 0 ? nodeInfo.tempInfo.Property4 : int(nodeInfo.tempInfo.Property3));
         var _loc4_:String = LanguageMgr.GetTranslation("public.time.hour");
         _loc5_.addItem(LanguageMgr.GetTranslation("map.PhysicsFieldView.info03"),_loc3_ + "/" + _loc4_);
         var _loc1_:int = int(PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
         var _loc2_:int = int(nodeInfo.createDate.time);
         _loc2_ = _loc1_ * 1000 - _loc2_;
         var _loc6_:int = int(nodeInfo.tempInfo.RefreshTime);
         _loc6_ = _loc6_ - _loc2_ / 1000;
         _loc6_ = int(_loc6_ < 0 ? 0 : _loc6_);
         _loc5_.addItem(LanguageMgr.GetTranslation("map.PhysicsFieldView.info04"),String(_loc6_));
         return _loc5_;
      }
      
      public function get nodeInfo() : WildLand
      {
         return info as WildLand;
      }
      
      override protected function setClearView() : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         if(_name)
         {
            if(_name.parent)
            {
               _name.parent.removeChild(_name);
            }
            _name.dispose();
         }
         _name = null;
         if(_owner)
         {
            if(_owner.parent)
            {
               _owner.parent.removeChild(_owner);
            }
            _owner.dispose();
         }
         _owner = null;
         super.dispose();
      }
      
      override public function set isPlaying(param1:Boolean) : void
      {
         super.isPlaying = param1;
         if(param1)
         {
            if(_owner)
            {
               addChild(_owner);
            }
            if(_name)
            {
               addChild(_name);
            }
         }
         else
         {
            if(_owner && _owner.parent)
            {
               _owner.parent.removeChild(_owner);
            }
            if(_name && _name.parent)
            {
               _name.parent.removeChild(_name);
            }
         }
      }
   }
}

