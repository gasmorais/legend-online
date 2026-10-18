package armyII.viewII.equip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.SuiteTempInfo;
   import yishi.manager.TempleteManager;
   
   public class MedalAttributeView extends Sprite implements Disposeable
   {
      
      private var _attributeTxt1:FilterFrameText;
      
      private var _attributeTxt2:FilterFrameText;
      
      private var _attributeTxt3:FilterFrameText;
      
      private var _attributeTxt4:FilterFrameText;
      
      private var _attributeTxt5:FilterFrameText;
      
      private var _attributeTxt6:FilterFrameText;
      
      private var _attributeTxt7:FilterFrameText;
      
      private var _addTxt1:FilterFrameText;
      
      private var _addTxt2:FilterFrameText;
      
      private var _addTxt3:FilterFrameText;
      
      private var _addTxt4:FilterFrameText;
      
      private var _addTxt5:FilterFrameText;
      
      private var _addTxt6:FilterFrameText;
      
      private var _addTxt7:FilterFrameText;
      
      private var _addFlag1:Image;
      
      private var _addFlag2:Image;
      
      private var _addFlag3:Image;
      
      private var _addFlag4:Image;
      
      private var _addFlag5:Image;
      
      private var _addFlag6:Image;
      
      private var _addFlag7:Image;
      
      private var _index:int;
      
      public function MedalAttributeView()
      {
         super();
         initView();
         addEvent();
         clean();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 7)
         {
            this["_attributeTxt" + _loc1_] = ComponentFactory.Instance.creatComponentByStylename("army.MedalAttributeView.AttributeTxt" + _loc1_);
            this["_addTxt" + _loc1_] = ComponentFactory.Instance.creatComponentByStylename("army.MedalAttributeView.AddTxt" + _loc1_);
            this["_addFlag" + _loc1_] = ComponentFactory.Instance.creatComponentByStylename("army.MedalAttributeView.AddFlag" + _loc1_);
            addChild(this["_attributeTxt" + _loc1_]);
            addChild(this["_addTxt" + _loc1_]);
            addChild(this["_addFlag" + _loc1_]);
            _loc1_++;
         }
      }
      
      private function uninitView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 7)
         {
            ObjectUtils.disposeObject(this["_attributeTxt" + _loc1_]);
            this["_attributeTxt" + _loc1_] = null;
            ObjectUtils.disposeObject(this["_addTxt" + _loc1_]);
            this["_addTxt" + _loc1_] = null;
            ObjectUtils.disposeObject(this["_addFlag" + _loc1_]);
            this["_addFlag" + _loc1_] = null;
            _loc1_++;
         }
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function clean() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 7)
         {
            this["_attributeTxt" + _loc1_].text = "";
            this["_addTxt" + _loc1_].text = "";
            this["_addFlag" + _loc1_].visible = false;
            _loc1_++;
         }
      }
      
      public function updateContent(param1:GoodsInfo, param2:GoodsInfo, param3:int = 1) : void
      {
         var _loc4_:String = null;
         var _loc6_:int = 0;
         var _loc5_:SuiteTempInfo = null;
         var _loc7_:SkillTempInfo = null;
         clean();
         _index = 0;
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01") + " +" + param1.templateInfo.Power;
         updateText(_loc4_,param3,param1.templateInfo.Power,param2.templateInfo.Power);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02") + " +" + param1.templateInfo.Agility;
         updateText(_loc4_,param3,param1.templateInfo.Agility,param2.templateInfo.Agility);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03") + " +" + param1.templateInfo.Intellect;
         updateText(_loc4_,param3,param1.templateInfo.Intellect,param2.templateInfo.Intellect);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04") + " +" + param1.templateInfo.Physique;
         updateText(_loc4_,param3,param1.templateInfo.Physique,param2.templateInfo.Physique);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05") + " +" + param1.templateInfo.Captain;
         updateText(_loc4_,param3,param1.templateInfo.Captain,param2.templateInfo.Captain);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13") + " +" + param1.templateInfo.Attack;
         updateText(_loc4_,param3,param1.templateInfo.Attack,param2.templateInfo.Attack);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15") + " +" + param1.templateInfo.MagicAttack;
         updateText(_loc4_,param3,param1.templateInfo.MagicAttack,param2.templateInfo.MagicAttack);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14") + " +" + param1.templateInfo.Defence;
         updateText(_loc4_,param3,param1.templateInfo.Defence,param2.templateInfo.Defence);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16") + " +" + param1.templateInfo.MagicDefence;
         updateText(_loc4_,param3,param1.templateInfo.MagicDefence,param2.templateInfo.MagicDefence);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19") + " +" + param1.templateInfo.Parry;
         updateText(_loc4_,param3,param1.templateInfo.Parry,param2.templateInfo.Parry);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11") + " +" + param1.templateInfo.Live;
         updateText(_loc4_,param3,param1.templateInfo.Live,param2.templateInfo.Live);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10") + " +" + param1.templateInfo.ForceHit;
         updateText(_loc4_,param3,param1.templateInfo.ForceHit,param2.templateInfo.ForceHit);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip17") + " +" + param1.templateInfo.Conat;
         updateText(_loc4_,param3,param1.templateInfo.Conat,param2.templateInfo.Conat);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip23","+" + param1.templateInfo.Strength);
         updateText(_loc4_,param3,param1.templateInfo.Strength,param2.templateInfo.Strength);
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip24","+" + param1.templateInfo.Tenacity);
         updateText(_loc4_,param3,param1.templateInfo.Tenacity,param2.templateInfo.Tenacity);
         if(param3 == 1)
         {
            _loc6_ = int(param1.templateInfo.SuiteId);
         }
         else
         {
            _loc6_ = int(param2.templateInfo.SuiteId);
         }
         _loc5_ = TempleteManager.instance.suitTemplateCate.getTemplateByID(_loc6_);
         _loc7_ = TempleteManager.instance.getSkillTemplateInfoById(_loc5_.Property1);
         _attributeTxt7.text = _loc7_.TemplateName;
      }
      
      private function updateText(param1:String, param2:int = 1, param3:int = 0, param4:int = 0) : void
      {
         var _loc5_:int = 0;
         if(param3 > 0)
         {
            _index = _index + 1;
         }
         if(_index >= 1 && _index <= 6 && param3 > 0)
         {
            if(param2 == 1)
            {
               this["_attributeTxt" + _index].text = param1;
            }
            else
            {
               this["_attributeTxt" + _index].text = param1;
               _loc5_ = param4 - param3;
               if(_loc5_ > 0)
               {
                  this["_addTxt" + _index].text = _loc5_.toString();
                  this["_addFlag" + _index].visible = true;
               }
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

