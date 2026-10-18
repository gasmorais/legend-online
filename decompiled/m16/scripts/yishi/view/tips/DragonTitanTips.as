package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.DragonTitanTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.goods.FashionAttItem;
   
   public class DragonTitanTips extends BaseTip
   {
      
      private var _titanId:int = 0;
      
      private var _icon:BaseIconView;
      
      private var _titanName:FilterFrameText;
      
      private var _titanSkill:FilterFrameText;
      
      private var _totalBox:VBox;
      
      private var _attack:FashionAttItem;
      
      private var _magicAttack:FashionAttItem;
      
      private var _defence:FashionAttItem;
      
      private var _magicDefence:FashionAttItem;
      
      private var _parry:FashionAttItem;
      
      private var _live:FashionAttItem;
      
      private var _forceHit:FashionAttItem;
      
      private var _strength:FashionAttItem;
      
      private var _tenacity:FashionAttItem;
      
      private var _penetrate:FashionAttItem;
      
      private var _stunAttr:FashionAttItem;
      
      private var _qualiLimit:FashionAttItem;
      
      public function DragonTitanTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _icon = ComponentFactory.Instance.creatCustomObject("dragontitan.DragonTitanTips.icon");
         _titanName = ComponentFactory.Instance.creatComponentByStylename("DragonTitanTips.titanName");
         _titanSkill = ComponentFactory.Instance.creatComponentByStylename("DragonTitanTips.titanSkill");
         _attack = new FashionAttItem();
         _magicAttack = new FashionAttItem();
         _defence = new FashionAttItem();
         _magicDefence = new FashionAttItem();
         _parry = new FashionAttItem();
         _live = new FashionAttItem();
         _forceHit = new FashionAttItem();
         _strength = new FashionAttItem();
         _tenacity = new FashionAttItem();
         _penetrate = new FashionAttItem();
         _stunAttr = new FashionAttItem();
         _qualiLimit = new FashionAttItem();
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("DragonTitanTips.VBox");
         _bg.width = 286;
         addChild(_icon);
         addChild(_titanName);
         addChild(_totalBox);
      }
      
      override protected function updateTransform() : void
      {
         clean();
         _titanId = tipData as int;
         var _loc3_:DragonTitanTempInfo = TempleteManager.instance.titanTemplateCate.getTemplateById(_titanId);
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillById(parseInt(_loc3_.SkillIds));
         _icon.icon = IconFactory.getCommonIconPath(_loc3_.AvatarPath);
         _titanName.text = _loc3_.TemplateName;
         addSplitLine();
         var _loc1_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
         updateAttributeTxt(_attack,_loc1_,_loc3_.Attack);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
         updateAttributeTxt(_magicAttack,_loc1_,_loc3_.MagicAttack);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
         updateAttributeTxt(_defence,_loc1_,_loc3_.Defence);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
         updateAttributeTxt(_magicDefence,_loc1_,_loc3_.MagicDefence);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
         updateAttributeTxt(_parry,_loc1_,_loc3_.Parry);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
         updateAttributeTxt(_live,_loc1_,_loc3_.Live);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
         updateAttributeTxt(_forceHit,_loc1_,_loc3_.ForceHit);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip23","");
         updateAttributeTxt(_strength,_loc1_,_loc3_.Strength);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip24","");
         updateAttributeTxt(_tenacity,_loc1_,_loc3_.Tenacity);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
         updateAttributeTxt(_penetrate,_loc1_,_loc3_.Penetrate);
         _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Dingli");
         updateAttributeTxt(_stunAttr,_loc1_,_loc3_.StunAttr);
         _loc1_ = LanguageMgr.GetTranslation("DragonTitanTips.QualiLimit");
         updateAttributeTxt(_qualiLimit,_loc1_,_loc3_.QualiLimit);
         addSplitLine();
         _titanSkill.htmlText = LanguageMgr.GetTranslation("DragonTitanTips.skillInfo",_loc2_.TemplateName,_loc2_.Description);
         _totalBox.addChild(_titanSkill);
         _bg.height = _totalBox.y + _totalBox.height + 10;
      }
      
      private function updateAttributeTxt(param1:FashionAttItem, param2:String, param3:Number) : void
      {
         if(param3 != 0)
         {
            param1.setData(param2 + " +" + param3);
            _totalBox.addChild(param1);
         }
      }
      
      private function addSplitLine() : void
      {
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _totalBox.addChild(_loc1_);
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

