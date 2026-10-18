package map.internals.view.physics
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import map.internals.data.WildLand;
   import yishi.manager.PathManager;
   import yishi.view.tips.MultipleDictionaryInfo;
   
   public class PhysicsTreasureView extends MapPhysicsAttackingBase
   {
      
      private var _name:FilterFrameText;
      
      public function PhysicsTreasureView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         if(_name)
         {
            if(_name.parent)
            {
               _name.parent.removeChild(_name);
            }
            _name = null;
         }
         if(!_name)
         {
            _name = ComponentFactory.Instance.creatComponentByStylename("outercity.OutercityNameText");
         }
         _name.text = LanguageMgr.GetTranslation("public.level.name",nodeInfo.tempInfo.MapPhysicsTempName,nodeInfo.info.grade);
         _name.setFrame(4);
      }
      
      override public function dispose() : void
      {
         if(_name)
         {
            _name.dispose();
         }
         _name = null;
         super.dispose();
      }
      
      override protected function layouCallBack() : void
      {
         if(isRemoveStage)
         {
            return;
         }
         _name.x = -_name.width / 2;
         _name.y = moviePos.y - _name.height;
         if(_isPlaying)
         {
            addChild(_name);
         }
      }
      
      override protected function get resourcesPath() : String
      {
         return PathManager.solveMapPhysicsBySonType(nodeInfo.tempInfo.SonType);
      }
      
      override protected function setClearView() : void
      {
         dispose();
      }
      
      override public function get tipData() : Object
      {
         var _loc2_:MultipleDictionaryInfo = new MultipleDictionaryInfo();
         var _loc1_:String = LanguageMgr.GetTranslation("public.playerInfo.ap");
         _loc2_.addItem(nodeInfo.tempInfo.MapPhysicsTempName + " Nv." + nodeInfo.tempInfo.Grades,null);
         _loc2_.addItem(_loc1_,String(nodeInfo.fightCapaity));
         return _loc2_;
      }
      
      public function get nodeInfo() : WildLand
      {
         return info as WildLand;
      }
      
      override public function set isPlaying(param1:Boolean) : void
      {
         super.isPlaying = param1;
         if(param1)
         {
            if(_name)
            {
               addChild(_name);
            }
         }
         else if(_name && _name.parent)
         {
            _name.parent.removeChild(_name);
         }
      }
   }
}

