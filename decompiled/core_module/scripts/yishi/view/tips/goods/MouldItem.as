package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.utils.GoodsHelp;
   
   public class MouldItem extends Sprite implements Disposeable
   {
      
      private var _mouldTitle:FilterFrameText;
      
      private var _subBox:VBox;
      
      private var _power:FilterFrameText;
      
      private var _agility:FilterFrameText;
      
      private var _ability:FilterFrameText;
      
      private var _physique:FilterFrameText;
      
      private var _captain:FilterFrameText;
      
      private var _attack:FilterFrameText;
      
      private var _magicAttack:FilterFrameText;
      
      private var _defence:FilterFrameText;
      
      private var _magicDefence:FilterFrameText;
      
      private var _parry:FilterFrameText;
      
      private var _live:FilterFrameText;
      
      private var _forceHit:FilterFrameText;
      
      private var _conat:FilterFrameText;
      
      private var _mouldStar:MovieImage;
      
      private var _mouldMoon:MovieImage;
      
      private var _mouldDay:MovieImage;
      
      private var _goodsInfo:GoodsInfo;
      
      private var _tempInfo:GoodsInfo;
      
      private var _mouldGrade:int;
      
      public function MouldItem()
      {
         super();
         _mouldTitle = ComponentFactory.Instance.creatComponentByStylename("core.MouldTitleText");
         _subBox = ComponentFactory.Instance.creatComponentByStylename("core.MouldSubBox");
         _power = ComponentFactory.Instance.creatComponentByStylename("core.MouldItemText");
         _agility = ComponentFactory.Instance.creatComponentByStylename("core.MouldItemText");
         _ability = ComponentFactory.Instance.creatComponentByStylename("core.MouldItemText");
         _physique = ComponentFactory.Instance.creatComponentByStylename("core.MouldItemText");
         _captain = ComponentFactory.Instance.creatComponentByStylename("core.MouldItemText");
         _attack = ComponentFactory.Instance.creatComponentByStylename("core.MouldItemText");
         _magicAttack = ComponentFactory.Instance.creatComponentByStylename("core.MouldItemText");
         _defence = ComponentFactory.Instance.creatComponentByStylename("core.MouldItemText");
         _magicDefence = ComponentFactory.Instance.creatComponentByStylename("core.MouldItemText");
         _parry = ComponentFactory.Instance.creatComponentByStylename("core.MouldItemText");
         _live = ComponentFactory.Instance.creatComponentByStylename("core.MouldItemText");
         _forceHit = ComponentFactory.Instance.creatComponentByStylename("core.MouldItemText");
         _conat = ComponentFactory.Instance.creatComponentByStylename("core.MouldItemText");
         _mouldStar = ComponentFactory.Instance.creatComponentByStylename("core.MouldStarBar");
         _mouldMoon = ComponentFactory.Instance.creatComponentByStylename("core.MouldMoonBar");
         _mouldDay = ComponentFactory.Instance.creatComponentByStylename("core.MouldDayBar");
         addChild(_mouldTitle);
         addChild(_subBox);
         addChild(_mouldStar);
         addChild(_mouldMoon);
         addChild(_mouldDay);
         _tempInfo = new GoodsInfo();
         _mouldStar.visible = false;
         _mouldMoon.visible = false;
         _mouldDay.visible = false;
      }
      
      public function setData(param1:GoodsInfo, param2:int, param3:Boolean = false) : void
      {
         _goodsInfo = param1;
         _mouldGrade = param2;
         _tempInfo.mouldGrade = _mouldGrade;
         if(_goodsInfo && param2 <= _goodsInfo.MOULD_MAX_GRADE)
         {
            if(_mouldGrade > 0)
            {
               _mouldTitle.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.MouldItem.Tips01",_tempInfo.mouldRankShow);
               _mouldStar.setFrame(_tempInfo.mouldStar);
               _mouldMoon.setFrame(_tempInfo.mouldStar);
               _mouldDay.setFrame(_tempInfo.mouldStar);
               if(_tempInfo.mouldRank > 16)
               {
                  _mouldStar.visible = false;
                  _mouldMoon.visible = false;
                  _mouldDay.visible = true;
               }
               else if(_tempInfo.mouldRank > 8)
               {
                  _mouldStar.visible = false;
                  _mouldMoon.visible = true;
                  _mouldDay.visible = false;
               }
               else
               {
                  _mouldStar.visible = true;
                  _mouldMoon.visible = false;
                  _mouldDay.visible = false;
               }
               initAttribute(_goodsInfo,_goodsInfo.templateInfo);
               if(param3)
               {
                  setItemFrame(3);
               }
               else
               {
                  setItemFrame(2);
               }
               _subBox.y = 40;
            }
            else
            {
               _mouldTitle.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.MouldItem.Tips02");
               _mouldStar.visible = false;
               _mouldMoon.visible = false;
               _mouldDay.visible = false;
               initAttribute(_goodsInfo,_goodsInfo.templateInfo);
               setItemFrame(1);
               _subBox.y = 21;
            }
         }
         else
         {
            _mouldTitle.text = "";
            _mouldStar.visible = false;
            _mouldMoon.visible = false;
            _mouldDay.visible = false;
            _subBox.removeAllChild();
         }
      }
      
      private function setItemFrame(param1:int) : void
      {
         _power.setFrame(param1);
         _agility.setFrame(param1);
         _ability.setFrame(param1);
         _physique.setFrame(param1);
         _captain.setFrame(param1);
         _attack.setFrame(param1);
         _magicAttack.setFrame(param1);
         _defence.setFrame(param1);
         _magicDefence.setFrame(param1);
         _parry.setFrame(param1);
         _live.setFrame(param1);
         _forceHit.setFrame(param1);
         _conat.setFrame(param1);
      }
      
      private function initAttribute(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         var _loc3_:String = null;
         _subBox.removeAllChild();
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01") + ":";
         updateAttributeTxt(_power,_loc3_,param2.Power,getAdd(param2.Power,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02");
         updateAttributeTxt(_agility,_loc3_,param2.Agility,getAdd(param2.Agility,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03");
         updateAttributeTxt(_ability,_loc3_,param2.Intellect,getAdd(param2.Intellect,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04");
         updateAttributeTxt(_physique,_loc3_,param2.Physique,getAdd(param2.Physique,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05");
         updateAttributeTxt(_captain,_loc3_,param2.Captain,getAdd(param2.Captain,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
         updateAttributeTxt(_attack,_loc3_,param2.Attack,getAdd(param2.Attack,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
         updateAttributeTxt(_magicAttack,_loc3_,param2.MagicAttack,getAdd(param2.MagicAttack,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
         updateAttributeTxt(_defence,_loc3_,param2.Defence,getAdd(param2.Defence,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
         updateAttributeTxt(_magicDefence,_loc3_,param2.MagicDefence,getAdd(param2.MagicDefence,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
         updateAttributeTxt(_parry,_loc3_,param2.Parry,getAdd(param2.Parry,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
         updateAttributeTxt(_live,_loc3_,param2.Live,getAdd(param2.Live,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
         updateAttributeTxt(_forceHit,_loc3_,param2.ForceHit,getAdd(param2.ForceHit,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip17");
         updateAttributeTxt(_conat,_loc3_,param2.Conat,getAdd(param2.Conat,param1));
      }
      
      private function updateAttributeTxt(param1:FilterFrameText, param2:String, param3:Number, param4:Number) : void
      {
         if(param3 != 0)
         {
            param1.text = param2 + " " + param4;
            _subBox.addChild(param1);
         }
      }
      
      private function getAdd(param1:int, param2:GoodsInfo) : int
      {
         var _loc3_:int = GoodsHelp.getMouldAddition(param1,getPropertyMouldGrade(param2));
         if(_loc3_ > 0)
         {
         }
         return _loc3_;
      }
      
      private function getPropertyMouldGrade(param1:GoodsInfo) : int
      {
         if(_mouldGrade < 1)
         {
            return 1;
         }
         if(_mouldGrade > param1.MOULD_MAX_GRADE)
         {
            return param1.MOULD_MAX_GRADE;
         }
         return _mouldGrade;
      }
      
      public function dispose() : void
      {
         _subBox.removeAllChild();
         ObjectUtils.disposeObject(_mouldTitle);
         _mouldTitle = null;
         ObjectUtils.disposeObject(_subBox);
         _subBox = null;
         ObjectUtils.disposeObject(_power);
         _power = null;
         ObjectUtils.disposeObject(_agility);
         _agility = null;
         ObjectUtils.disposeObject(_ability);
         _ability = null;
         ObjectUtils.disposeObject(_physique);
         _physique = null;
         ObjectUtils.disposeObject(_captain);
         _captain = null;
         ObjectUtils.disposeObject(_attack);
         _attack = null;
         ObjectUtils.disposeObject(_magicAttack);
         _magicAttack = null;
         ObjectUtils.disposeObject(_defence);
         _defence = null;
         ObjectUtils.disposeObject(_magicDefence);
         _magicDefence = null;
         ObjectUtils.disposeObject(_parry);
         _parry = null;
         ObjectUtils.disposeObject(_live);
         _live = null;
         ObjectUtils.disposeObject(_forceHit);
         _forceHit = null;
         ObjectUtils.disposeObject(_conat);
         _conat = null;
         ObjectUtils.disposeObject(_mouldStar);
         _mouldStar = null;
         ObjectUtils.disposeObject(_mouldMoon);
         _mouldMoon = null;
         ObjectUtils.disposeObject(_mouldDay);
         _mouldDay = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

