package landmine
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.landmine.LandMineSapperInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   
   public class LandMineTeamHeroView extends Sprite implements Disposeable
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _showAvatar:ShowAvatar;
      
      private var _data:LandMineSapperInfo;
      
      public function LandMineTeamHeroView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineTeamHeroView.nameTxt");
         _showAvatar = ComponentFactory.Instance.creatCustomObject("landmine.LandMineTeamHeroView.showAvatar");
         addChild(_nameTxt);
         addChild(_showAvatar);
      }
      
      private function get self() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_showAvatar);
         _showAvatar = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function reset() : void
      {
         _nameTxt.text = "";
         _showAvatar.data = null;
      }
      
      private function updateHeroView() : void
      {
         var _loc1_:ThaneInfo = new ThaneInfo();
         _loc1_.userId = data.userId;
         _loc1_.sexs = data.sex;
         _loc1_.nickName = data.nickName;
         _loc1_.templateId = data.templateId;
         _loc1_.armsEquipAvata = data.arm;
         _loc1_.wingAvata = data.wing;
         _loc1_.hairFashionAvata = data.hat;
         _loc1_.bodyEquipAvata = data.cloth;
         _loc1_.armsFashionAvata = data.fashionArm;
         _loc1_.bodyFashionAvata = data.fashionCloth;
         _loc1_.hideFashion = data.hide;
         _nameTxt.text = _loc1_.nickName;
         _showAvatar.data = _loc1_;
      }
      
      public function get data() : LandMineSapperInfo
      {
         return _data;
      }
      
      public function set data(param1:LandMineSapperInfo) : void
      {
         reset();
         _data = param1;
         if(data)
         {
            updateHeroView();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

