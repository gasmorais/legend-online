package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   
   public class JewelSuitTips extends BaseTip
   {
      
      private var _vBox:VBox;
      
      private var _line1:ScaleBitmapImage;
      
      private var _name:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _head:Sprite;
      
      private var _current:FilterFrameText;
      
      private var _currentValue:FilterFrameText;
      
      private var _currentCon:Sprite;
      
      private var _next:FilterFrameText;
      
      private var _nextValue:FilterFrameText;
      
      private var _nextCon:Sprite;
      
      public function JewelSuitTips()
      {
         super();
         _bg.width = 260;
         _vBox = new VBox();
         _vBox.y = 13;
         _vBox.x = 11;
         _vBox.spacing = 5;
         _line1 = ComponentFactory.Instance.creatComponentByStylename("tips.HeroTipLine1");
         _line1.width = _bg.width - 15;
         _name = ComponentFactory.Instance.creatComponentByStylename("tips.JewelTipName");
         _level = ComponentFactory.Instance.creatComponentByStylename("tips.JewelTipValue");
         _head = new Sprite();
         _head.addChild(_name);
         _head.addChild(_level);
         _current = ComponentFactory.Instance.creatComponentByStylename("tips.JewelTipName");
         _currentValue = ComponentFactory.Instance.creatComponentByStylename("tips.JewelTipValue");
         _currentValue.x = 86;
         _currentCon = new Sprite();
         _currentCon.addChild(_current);
         _currentCon.addChild(_currentValue);
         _next = ComponentFactory.Instance.creatComponentByStylename("tips.JewelTipName");
         _nextValue = ComponentFactory.Instance.creatComponentByStylename("tips.JewelTipValue");
         _nextValue.x = 86;
         _nextCon = new Sprite();
         _nextCon.addChild(_next);
         _nextCon.addChild(_nextValue);
         addChild(_vBox);
         _name.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelNameTxt");
         _level.x = _name.x + _name.textWidth + 5;
         _current.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelCurrentEffTxt");
         _next.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelNextEffTxt");
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:int = 0;
         var _loc1_:UpgradeTemplateInfo = null;
         if(tipData)
         {
            _loc2_ = int((tipData as ThaneInfo).jewelGrades);
            _vBox.removeAllChild();
            _level.text = LanguageMgr.GetTranslation("public.level2",_loc2_);
            _currentValue.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelEffValueTxt",GoodsHelp.getJewelEffecyByGrade(_loc2_));
            _loc1_ = TempleteManager.instance.getTemplateByLevelAndType(_loc2_ + 1,15);
            _name.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelNameTxt");
            if((tipData as ThaneInfo).jewelGrades >= 80 && (tipData as ThaneInfo).vocationGrades > 0)
            {
               _loc2_ = int((tipData as ThaneInfo).seniorStoreGrade);
               _name.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelTitleTxt02");
               _level.text = LanguageMgr.GetTranslation("public.level2",_loc2_);
               _currentValue.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelEffValueTxt",GoodsHelp.getSeniorJewelEffecyByGrade(_loc2_));
               _loc1_ = TempleteManager.instance.getTemplateByLevelAndType(_loc2_ + 1,104);
            }
            if(_loc1_)
            {
               if((tipData as ThaneInfo).jewelGrades >= 80 && (tipData as ThaneInfo).vocationGrades > 0)
               {
                  _nextValue.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelEffValueTxt",GoodsHelp.getSeniorJewelEffecyByGrade(_loc2_ + 1));
               }
               else
               {
                  _nextValue.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelEffValueTxt",GoodsHelp.getJewelEffecyByGrade(_loc2_ + 1));
               }
            }
            else
            {
               _loc1_ = TempleteManager.instance.getTemplateByLevelAndType(_loc2_,15);
               _nextValue.text = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command03");
            }
            _vBox.addChild(_head);
            _vBox.addChild(_line1);
            _vBox.addChild(_currentCon);
            _vBox.addChild(_nextCon);
            _vBox.refreshChildPos();
            _bg.height = 100;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_head);
         ObjectUtils.disposeAllChildren(_currentCon);
         ObjectUtils.disposeAllChildren(_nextCon);
         if(_vBox)
         {
            ObjectUtils.disposeObject(_vBox);
         }
         _vBox = null;
         if(_line1)
         {
            ObjectUtils.disposeObject(_line1);
         }
         _line1 = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_level)
         {
            ObjectUtils.disposeObject(_level);
         }
         _level = null;
         if(_head)
         {
            ObjectUtils.disposeObject(_head);
         }
         _head = null;
         if(_current)
         {
            ObjectUtils.disposeObject(_current);
         }
         _current = null;
         if(_currentValue)
         {
            ObjectUtils.disposeObject(_currentValue);
         }
         _currentValue = null;
         if(_currentCon)
         {
            ObjectUtils.disposeObject(_currentCon);
         }
         _currentCon = null;
         if(_next)
         {
            ObjectUtils.disposeObject(_next);
         }
         _next = null;
         if(_nextValue)
         {
            ObjectUtils.disposeObject(_nextValue);
         }
         _nextValue = null;
         if(_nextCon)
         {
            ObjectUtils.disposeObject(_nextCon);
         }
         _nextCon = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

