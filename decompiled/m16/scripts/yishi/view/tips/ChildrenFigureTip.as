package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.goods.FashionAttItem;
   
   public class ChildrenFigureTip extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      private var _subBox1:VBox;
      
      private var _subBox2:VBox;
      
      private var _splitLine:Bitmap;
      
      private var _splitLine2:Bitmap;
      
      private var _splitLine3:Bitmap;
      
      private var _txtList:Vector.<FashionAttItem>;
      
      private var _goodsList:Vector.<GoodsInfo>;
      
      private var _con:Sprite;
      
      private var _equipIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _title:FilterFrameText;
      
      private var _type:FilterFrameText;
      
      private var _vocation:FilterFrameText;
      
      private var _powerTxt:FilterFrameText;
      
      private var dreamArenaChildData:ChildData;
      
      private var _attNameList:Array = ["Emblem1","Emblem2","Emblem3","Emblem4","Emblem5","Emblem6","Emblem7","Emblem8","Emblem9","Attack","Defence","MagicAttack","MagicDefence","ForceHit","Penetrate","Parry","Live","StunAttr"];
      
      private var _attStrList:Array = ["tips.ChildrenFigureTip.typeText01","tips.ChildrenFigureTip.typeText02","tips.ChildrenFigureTip.typeText03","tips.ChildrenFigureTip.typeText04","tips.ChildrenFigureTip.typeText05","tips.ChildrenFigureTip.typeText06","tips.ChildrenFigureTip.typeText07","tips.ChildrenFigureTip.typeText17","tips.ChildrenFigureTip.typeText18","tips.ChildrenFigureTip.typeText08","tips.ChildrenFigureTip.typeText09","tips.ChildrenFigureTip.typeText10","tips.ChildrenFigureTip.typeText11","tips.ChildrenFigureTip.typeText12","tips.ChildrenFigureTip.typeText13","tips.ChildrenFigureTip.typeText14","tips.ChildrenFigureTip.typeText15","tips.ChildrenFigureTip.typeText16"];
      
      public function ChildrenFigureTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc1_:FashionAttItem = null;
         var _loc2_:int = 0;
         super.init();
         _bg.width = 266;
         _con = new Sprite();
         _equipIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _type = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText_2");
         _vocation = ComponentFactory.Instance.creatComponentByStylename("tips.GoodVocationText");
         _powerTxt = ComponentFactory.Instance.creatComponentByStylename("tips.pet.PowerTxt");
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine.x = -7;
         _splitLine.scaleX = 0.95;
         _splitLine2 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine2.x = -7;
         _splitLine2.scaleX = 0.95;
         _splitLine3 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine3.x = -7;
         _splitLine3.scaleX = 0.95;
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _subBox1 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _subBox2 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _txtList = new Vector.<FashionAttItem>();
         _goodsList = new Vector.<GoodsInfo>();
         addChild(_con);
         addChild(_totalBox);
         _loc2_ = 0;
         while(_loc2_ < _attNameList.length)
         {
            _loc1_ = new FashionAttItem();
            if(_loc2_ < 9)
            {
               _subBox1.addChild(_loc1_);
            }
            else
            {
               _subBox2.addChild(_loc1_);
            }
            _txtList.push(_loc1_);
            _loc2_++;
         }
         _profileImg.setFrame(1);
         _con.addChild(_equipIcon);
         _equipIcon.x = 15;
         _equipIcon.y = -9;
         _con.addChild(_title);
         _title.x = 71;
         _title.y = 20;
         _title.width = 150;
         _con.addChild(_profileImg);
         _profileImg.x = 15;
         _profileImg.y = 10;
         _con.addChild(_type);
         _type.x = 6;
         _type.y = 60;
         _con.addChild(_vocation);
         _vocation.x = 0;
         _vocation.y = 60;
         _totalBox.x = 10;
         _totalBox.y = 90;
         dreamArenaChildData = new ChildData();
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:ChildTempInfo = null;
         clean();
         if(tipData is ChildData)
         {
            _equipIcon.icon = IconFactory.getChildrenHeadSmallIcon(_data.job,_data.growthGrade);
            _title.text = _data.name;
            _type.text = LanguageMgr.GetTranslation("public.level2",_data.growthGrade);
            _loc1_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
            _vocation.text = _loc1_.JobName;
            _powerTxt.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.ap") + String(_data.fightValue);
            refreshView(_data as ChildData);
            _subBox1.refreshChildPos();
            _subBox2.refreshChildPos();
            _totalBox.addChild(_splitLine);
            _totalBox.addChild(_subBox1);
            _totalBox.addChild(_splitLine2);
            _totalBox.addChild(_subBox2);
            _totalBox.addChild(_splitLine3);
            _totalBox.addChild(_powerTxt);
            _bg.height = int(_totalBox.y + _totalBox.height + 10);
         }
         else if(tipData && tipData is DreamArenaTempInfo)
         {
            setTipsData(tipData as DreamArenaTempInfo,dreamArenaChildData);
            _equipIcon.icon = IconFactory.getChildrenHeadSmallIcon(dreamArenaChildData.job,dreamArenaChildData.growthGrade);
            _type.text = LanguageMgr.GetTranslation("public.level2",dreamArenaChildData.growthGrade);
            _loc1_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(dreamArenaChildData.job,dreamArenaChildData.growthGrade);
            _title.text = _loc1_.JobName;
            _vocation.text = _loc1_.JobName;
            refreshView(dreamArenaChildData);
            _subBox1.refreshChildPos();
            _subBox2.refreshChildPos();
            _totalBox.addChild(_splitLine);
            _totalBox.addChild(_subBox1);
            _totalBox.addChild(_splitLine2);
            _totalBox.addChild(_subBox2);
            _bg.height = int(_totalBox.y + _totalBox.height + 10);
         }
      }
      
      private function setTipsData(param1:DreamArenaTempInfo, param2:ChildData) : void
      {
         var _loc3_:SkillPropertyTempInfo = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(param1.PropertyId);
         if(!_loc3_)
         {
            return;
         }
         dreamArenaChildData.job = (param1.typeTempInfo as ChildTempInfo).JobType;
         dreamArenaChildData.growthGrade = (param1.typeTempInfo as ChildTempInfo).Grades;
         param2.childAttInfo.reduceResi = _loc3_.ReduceResi;
         param2.childAttInfo.fireResi = _loc3_.FireResi;
         param2.childAttInfo.waterResi = _loc3_.WaterResi;
         param2.childAttInfo.electResi = _loc3_.ElectResi;
         param2.childAttInfo.windResi = _loc3_.WindResi;
         param2.childAttInfo.darkResi = _loc3_.DarkResi;
         param2.childAttInfo.lightResi = _loc3_.LightResi;
         param2.childAttInfo.strikeResi = _loc3_.ResiPenetrate;
         param2.childAttInfo.resResistResi = _loc3_.ReduceResiAgainst;
         param2.childAttInfo.attack = _loc3_.Attack;
         param2.childAttInfo.defence = _loc3_.Defence;
         param2.childAttInfo.magicAttack = _loc3_.MagicAttack;
         param2.childAttInfo.magicDefence = _loc3_.MagicDefence;
         param2.childAttInfo.forceHit = _loc3_.ForceHit;
         param2.childAttInfo.penetrate = _loc3_.Penetrate;
         param2.childAttInfo.parry = _loc3_.Parry;
         param2.childAttInfo.hp = _loc3_.Live;
         param2.childAttInfo.stunAttr = _loc3_.StunAttr;
      }
      
      private function refreshView(param1:ChildData) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _attNameList.length)
         {
            if(_loc2_ < 9)
            {
               _txtList[_loc2_].setData(LanguageMgr.GetTranslation(_attStrList[_loc2_]) + " " + param1.childAttInfo.resiArr[_loc2_]);
            }
            else
            {
               _txtList[_loc2_].setData(LanguageMgr.GetTranslation(_attStrList[_loc2_]) + " " + param1.childAttInfo.attValueArr[_loc2_ - 9]);
            }
            _loc2_++;
         }
      }
      
      protected function clean() : void
      {
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      public function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

