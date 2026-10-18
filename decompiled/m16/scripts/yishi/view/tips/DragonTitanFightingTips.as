package yishi.view.tips
{
   import battle.BattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class DragonTitanFightingTips extends BaseTip
   {
      
      private var _titanSkill:FilterFrameText;
      
      private var _totalBox:VBox;
      
      public function DragonTitanFightingTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         MsgMan.addObserver("DragonTitanEvent.TITAN_SKILL_USE",this,_titanSkillUseHandle);
         _titanSkill = ComponentFactory.Instance.creatComponentByStylename("DragonTitanFightingTips.titanSkill");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("changejob.branchTotalBox");
         _bg.width = 286;
         _titanSkill.text = LanguageMgr.GetTranslation("DragonTitanFightingTips.titanSkill");
         addChild(_totalBox);
      }
      
      private function _titanSkillUseHandle(param1:String, param2:Object) : void
      {
         updateTransform();
      }
      
      override protected function updateTransform() : void
      {
         var _loc6_:HeroRoleInfo = null;
         var _loc5_:int = 0;
         var _loc3_:SkillTempInfo = null;
         var _loc4_:Bitmap = null;
         var _loc1_:DragonTitanSkillTipsItem = null;
         clean();
         _totalBox.addChild(_titanSkill);
         var _loc2_:RoleInfo = BattleManager.getInstance().battleModel.getRoleById(tipData as int);
         if(!_loc2_)
         {
            return;
         }
         _titanSkill.text = LanguageMgr.GetTranslation("DragonTitanFightingTips.titanSkill") + "(" + _loc2_.roleName + ")";
         if(_loc2_ is HeroRoleInfo)
         {
            _loc6_ = _loc2_ as HeroRoleInfo;
            _loc5_ = 0;
            while(_loc5_ < _loc6_.titanSkill.length)
            {
               _loc3_ = TempleteManager.instance.getSkillById(_loc6_.titanSkill[_loc5_]);
               if(_loc3_)
               {
                  _loc4_ = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
                  _totalBox.addChild(_loc4_);
                  _loc1_ = new DragonTitanSkillTipsItem();
                  _loc1_.index = _loc5_;
                  _loc1_.state = _loc6_.titanSkillUsed[_loc5_];
                  _loc1_.data = _loc3_;
                  _totalBox.addChild(_loc1_);
               }
               _loc5_++;
            }
         }
         _totalBox.spacing = -3;
         _bg.height = _totalBox.height + 20;
      }
      
      private function clean() : void
      {
         _totalBox.removeAllChild();
      }
      
      override public function dispose() : void
      {
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

