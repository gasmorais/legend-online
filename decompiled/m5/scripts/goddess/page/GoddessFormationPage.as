package goddess.page
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import goddess.item.GoddessFormationCard;
   import manager.LanguageMgr;
   import managers.GodDessManager;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.fashion.FashionModel;
   import mvc.module.goddess.GoddessFormationInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoddessFormationSkillTemp;
   import yishi.datas.templates.GoddessFormationTemp;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.ThaneEquipShowHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class GoddessFormationPage extends Component
   {
      
      private var _arrayBg:MutipleImage;
      
      private var _btnUpgrade1:BaseButton;
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _bit2:Bitmap;
      
      private var _txtArrayStoneCount:FilterFrameText;
      
      private var _txtArrayAdd1:FilterFrameText;
      
      private var _txtArrayCostCount:FilterFrameText;
      
      private var _txtArrayAdd3:FilterFrameText;
      
      private var _txtArrayAdd2:FilterFrameText;
      
      private var _txtArrayAdd4:FilterFrameText;
      
      private var _txtArrayJian:FilterFrameText;
      
      private var _txtArrayPlayerStr1:FilterFrameText;
      
      private var _txtArrayPlayerStr2:FilterFrameText;
      
      private var _txtArrayPlayerStr3:FilterFrameText;
      
      private var _txtArrayPlayerStr4:FilterFrameText;
      
      private var _txtArrayPlayerValue1:FilterFrameText;
      
      private var _txtArrayPlayerValue2:FilterFrameText;
      
      private var _txtArrayPlayerValue3:FilterFrameText;
      
      private var _txtArrayPlayerValue4:FilterFrameText;
      
      private var _txtPersent:FilterFrameText;
      
      private var _txtMaxTxt:FilterFrameText;
      
      private var _bit3:Bitmap;
      
      private var imgStone:Image;
      
      private var _imgName:ScaleFrameImage;
      
      private var _skill1:Image;
      
      private var _skill2:Image;
      
      private var _skill3:Image;
      
      private var _skill4:Image;
      
      private var imgMax:MutipleImage;
      
      private var cards:Vector.<GoddessFormationCard>;
      
      private var _numBMD:BitmapData;
      
      private var spLv1:Sprite;
      
      private var barMask:Sprite;
      
      private var _figure:ShowAvatar;
      
      private var selectedIndex:int = 1;
      
      private const STONE_ID:int = 212034;
      
      private var template_level_current:GoddessFormationTemp;
      
      private var template_level_next:GoddessFormationTemp;
      
      private var resultData:Array;
      
      private var maxImagePos:Array;
      
      private var headCard:GoddessFormationCard;
      
      private var _levelImage:Bitmap;
      
      private const MAX_CARD_COUNT:int = 5;
      
      private var cardsPos:Array = [[192,36],[27,147],[355,147],[43,326],[345,327]];
      
      private var _hasGoodsNum:int;
      
      private const MAX_LV:int = 50;
      
      public function GoddessFormationPage()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:GoddessFormationCard = null;
         var _loc1_:int = 0;
         _arrayBg = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.arrayBg");
         _btnUpgrade1 = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.btnUpgrade1");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.goddess.formation.progressbg");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.goddess.formation.progressbar");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.goddess.formation.str3");
         _txtArrayStoneCount = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayStoneCount");
         _txtArrayAdd1 = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayAdd1");
         _txtArrayCostCount = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayCostCount");
         _txtArrayAdd3 = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayAdd3");
         _txtArrayAdd2 = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayAdd2");
         _txtArrayAdd4 = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayAdd4");
         _txtArrayJian = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayJian");
         _txtArrayPlayerStr1 = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayPlayerStr1");
         _txtArrayPlayerStr2 = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayPlayerStr2");
         _txtArrayPlayerStr3 = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayPlayerStr3");
         _txtArrayPlayerStr4 = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayPlayerStr4");
         _txtArrayPlayerValue1 = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayPlayerValue1");
         _txtArrayPlayerValue2 = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayPlayerValue2");
         _txtArrayPlayerValue3 = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayPlayerValue3");
         _txtArrayPlayerValue4 = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtArrayPlayerValue4");
         imgStone = ComponentFactory.Instance.creatComponentByStylename("goddess.formation.stone");
         _txtPersent = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.txtPersent");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.goddess.formation.bg");
         _levelImage = ComponentFactory.Instance.creatBitmap("asset.goddess.formation.lv");
         _skill4 = ComponentFactory.Instance.creatComponentByStylename("goddess.formation.skill4");
         _skill3 = ComponentFactory.Instance.creatComponentByStylename("goddess.formation.skill3");
         _skill2 = ComponentFactory.Instance.creatComponentByStylename("goddess.formation.skill2");
         _skill1 = ComponentFactory.Instance.creatComponentByStylename("goddess.formation.skill1");
         imgMax = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.lvMax");
         _txtMaxTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.formation.txtMax");
         _imgName = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.imgName");
         addChild(_bit3);
         addChild(_arrayBg);
         addChild(_btnUpgrade1);
         addChild(_bit0);
         addChild(_bit1);
         addChild(imgStone);
         addChild(_txtArrayStoneCount);
         addChild(_txtArrayCostCount);
         addChild(_txtArrayAdd2);
         addChild(_txtArrayAdd4);
         addChild(_txtArrayJian);
         addChild(_txtArrayPlayerStr1);
         addChild(_txtArrayPlayerStr2);
         addChild(_txtArrayPlayerStr3);
         addChild(_txtArrayPlayerStr4);
         addChild(_txtArrayPlayerValue1);
         addChild(_txtArrayPlayerValue2);
         addChild(_txtArrayPlayerValue3);
         addChild(_txtArrayPlayerValue4);
         addChild(_txtPersent);
         addChild(_levelImage);
         addChild(_skill1);
         addChild(_skill2);
         addChild(_skill3);
         addChild(_skill4);
         _btnUpgrade1.addChild(_bit2);
         addChild(imgMax);
         addChild(_txtArrayAdd1);
         addChild(_txtArrayAdd3);
         addChild(_txtMaxTxt);
         addChild(_imgName);
         _figure = new ShowAvatar(true);
         _figure.x = 94;
         _figure.y = 123;
         _figure.mouseChildren = _figure.mouseEnabled = false;
         addChild(_figure);
         cards = new Vector.<GoddessFormationCard>();
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            _loc2_ = new GoddessFormationCard(_loc1_);
            addChild(_loc2_);
            _loc2_.x = cardsPos[_loc1_ - 1][0];
            _loc2_.y = cardsPos[_loc1_ - 1][1];
            _loc2_.clickCallback = cardClickCallback;
            cards.push(_loc2_);
            _loc1_++;
         }
         headCard = new GoddessFormationCard(0);
         addChild(headCard);
         headCard.setNormal();
         headCard.x = 499;
         headCard.y = 128;
         _numBMD = ComponentFactory.Instance.creatBitmapData("asset.goddess.formation.num");
         spLv1 = new Sprite();
         spLv1.x = 785;
         spLv1.y = 143;
         addChild(spLv1);
         barMask = new Sprite();
         barMask.graphics.beginFill(5592405,0.5);
         barMask.graphics.drawRect(0,0,_bit1.width,_bit1.height);
         barMask.x = _bit1.x;
         barMask.y = _bit1.y;
         addChild(barMask);
         _bit1.mask = barMask;
         _txtArrayJian.text = LanguageMgr.GetTranslation("goddess.array.text1",999);
         _txtArrayPlayerStr1.text = LanguageMgr.GetTranslation("goddess.array.proper1");
         _txtArrayPlayerStr2.text = LanguageMgr.GetTranslation("goddess.array.proper2");
         _txtArrayPlayerStr3.text = LanguageMgr.GetTranslation("goddess.array.proper3");
         _txtArrayPlayerStr4.text = LanguageMgr.GetTranslation("goddess.array.proper4");
         _txtMaxTxt.text = LanguageMgr.GetTranslation("goddess.array.text12");
         maxImagePos = [_txtArrayAdd1.x,_txtArrayAdd3.x,spLv1.x];
         cardClickCallback(1);
         refreshHeroFigure();
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = 212034;
         imgStone.tipData = _loc3_;
         this.mouseEnabled = false;
      }
      
      private function showSkillTip(param1:int) : void
      {
         var _loc5_:GoddessFormationSkillTemp = null;
         var _loc2_:Image = null;
         var _loc4_:int = 0;
         var _loc6_:Array = TempleteManager.instance.goddessFormationSkillTempCate.LV;
         var _loc3_:SkillInfo = new SkillInfo();
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc5_ = TempleteManager.instance.goddessFormationSkillTempCate.getTemplateByLevel(_loc6_[_loc4_]);
            _loc3_.templateId = _loc5_.SkillId;
            _loc2_ = this["_skill" + (int(_loc4_ + 1))] as Image;
            _loc2_.tipData = _loc3_.templateInfo.Description;
            if(param1 >= _loc5_.MinLevel)
            {
               _loc2_.filters = [];
            }
            else
            {
               _loc2_.filters = [UIFilter.getGrayFilter()];
            }
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("EVENT_ARRAY_GODDESS_CHANGE",this,goddessChange);
         _txtArrayCostCount.addEventListener("change",inputChangeHandler);
         _btnUpgrade1.addEventListener("click",onClickUpgrade);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("EVENT_ARRAY_GODDESS_CHANGE",this,goddessChange);
         _txtArrayCostCount.removeEventListener("change",inputChangeHandler);
         _btnUpgrade1.removeEventListener("click",onClickUpgrade);
      }
      
      private function inputChangeHandler(param1:Event) : void
      {
         var _loc2_:int = int(_txtArrayCostCount.text);
         if(_loc2_ > _hasGoodsNum)
         {
            _txtArrayCostCount.text = _hasGoodsNum + "";
         }
      }
      
      private function onClickUpgrade(param1:MouseEvent) : void
      {
         var _loc2_:int = int(_txtArrayCostCount.text);
         if(_loc2_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goddess.array.text15"));
            return;
         }
         GodDessManager.instance.requestFormationUpgrade(selectedIndex,_loc2_);
      }
      
      private function goddessChange(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function refreshHeroFigure() : void
      {
         var _loc2_:Dictionary = null;
         if(fashionModel.lookDragonTalkerFashion)
         {
            return;
         }
         var _loc1_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         var _loc6_:ThaneInfo = new ThaneInfo();
         _loc6_.templateId = thane.templateId;
         _loc6_.hideFashion = thane.hideFashion;
         _loc2_ = ArmyManager.instance.fashionList;
         var _loc5_:GoodsInfo = _loc2_[8];
         var _loc3_:GoodsInfo = _loc2_[9];
         var _loc7_:GoodsInfo = _loc2_[10];
         var _loc4_:GoodsInfo = _loc2_[11];
         _loc6_.hairEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(null);
         _loc6_.bodyEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(null);
         _loc6_.armsEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(null);
         if(_loc1_ && !_loc1_.isHidenWingAvata)
         {
            _loc6_.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc5_);
         }
         if(_loc1_ && !_loc1_.isHidenArmAvata)
         {
            _loc6_.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc4_);
         }
         if(_loc1_ && !_loc1_.isHidenClothAvata)
         {
            _loc6_.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc7_);
         }
         if(_loc1_ && !_loc1_.isHidenHatAvat)
         {
            _loc6_.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc3_);
         }
         _figure.data = _loc6_;
      }
      
      private function cardClickCallback(param1:int) : void
      {
         var _loc3_:GoddessFormationCard = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = cards[_loc2_];
            _loc3_.select = false;
            if(param1 - 1 == _loc2_)
            {
               _loc3_.select = true;
            }
            _loc2_++;
         }
         selectedIndex = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc4_:GoddessFormationCard = null;
         var _loc6_:GoddessFormationInfo = null;
         var _loc7_:GoddessFormationTemp = null;
         var _loc5_:GoddessFormationInfo = null;
         var _loc2_:Boolean = false;
         _hasGoodsNum = GoodsManager.instance.getGoodsNumByTempId(212034);
         _txtArrayCostCount.text = Math.min(_hasGoodsNum,1) + "";
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = cards[_loc3_];
            _loc6_ = GodDessManager.instance.model.formationMap.getValue(_loc3_ + 1) as GoddessFormationInfo;
            if(!_loc6_)
            {
               _loc6_ = new GoddessFormationInfo();
               _loc6_.templateId = _loc3_ + 1;
            }
            if(_loc6_)
            {
               _loc4_.data = _loc6_;
            }
            else
            {
               _loc4_.data = null;
            }
            if(_loc4_.select)
            {
               headCard.data = _loc4_.data;
            }
            _loc3_++;
         }
         imgMax.visible = false;
         var _loc1_:int = 2147483647;
         resultData = [0,0,0,0,0];
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc7_ = cards[_loc3_].levelTemplate;
            _loc5_ = cards[_loc3_].data;
            _loc1_ = Math.min(_loc1_,_loc5_.grade);
            resultData[0] += _loc7_.ReduceResi;
            resultData[1] += int(_loc7_.Permillage / 1000 * GodDessManager.instance.getGoddessInfoByFormationIndex(_loc3_ + 1).attack);
            resultData[2] += int(_loc7_.Permillage / 1000 * GodDessManager.instance.getGoddessInfoByFormationIndex(_loc3_ + 1).defance);
            resultData[3] += int(_loc7_.Permillage / 1000 * GodDessManager.instance.getGoddessInfoByFormationIndex(_loc3_ + 1).magicDefance);
            resultData[4] += int(_loc7_.Permillage / 1000 * GodDessManager.instance.getGoddessInfoByFormationIndex(_loc3_ + 1).live);
            _loc3_++;
         }
         _txtArrayJian.text = LanguageMgr.GetTranslation("goddess.array.text1",resultData[0]);
         _txtArrayPlayerValue1.text = resultData[1] + "";
         _txtArrayPlayerValue2.text = resultData[2] + "";
         _txtArrayPlayerValue3.text = resultData[3] + "";
         _txtArrayPlayerValue4.text = resultData[4] + "";
         _loc6_ = cards[selectedIndex - 1].data;
         _imgName.setFrame(selectedIndex);
         if(selectedIndex == 1)
         {
            _levelImage.x = 744;
         }
         else if(selectedIndex == 3)
         {
            _levelImage.x = 789;
         }
         else
         {
            _levelImage.x = 759;
         }
         spLv1.x = _levelImage.x + _levelImage.width + 2;
         template_level_current = cards[selectedIndex - 1].levelTemplate;
         template_level_next = cards[selectedIndex - 1].nextLevelTemplate;
         if(!template_level_current)
         {
            template_level_current = new GoddessFormationTemp();
         }
         if(_loc6_)
         {
            _txtPersent.text = _loc6_.gradeGp + "/" + template_level_next.NeedGp;
            setExpProgress(_loc6_.gradeGp / template_level_next.NeedGp);
            NumberViewUtils.refreshValue(_loc6_.grade,spLv1,_numBMD,18,24,15,18,"0123456789");
            _txtArrayAdd1.text = LanguageMgr.GetTranslation("goddess.array.add",template_level_current.ReduceResi);
            _txtArrayAdd2.text = LanguageMgr.GetTranslation("goddess.array.add",template_level_next.ReduceResi);
            _txtArrayAdd3.text = LanguageMgr.GetTranslation("goddess.array.ex0",template_level_current.Permillage / 10);
            _txtArrayAdd4.text = LanguageMgr.GetTranslation("goddess.array.ex0",template_level_next.Permillage / 10);
            if(_loc6_.grade >= 50)
            {
               _txtMaxTxt.visible = true;
               imgMax.visible = true;
               _txtArrayAdd1.x = maxImagePos[0] + 115;
               _txtArrayAdd3.x = maxImagePos[1] + 115;
               _txtArrayAdd2.text = LanguageMgr.GetTranslation("goddess.array.text11");
               _txtArrayAdd4.visible = false;
               _txtPersent.text = "MAX";
               setExpProgress(1);
               _btnUpgrade1.enable = false;
            }
            else
            {
               _txtMaxTxt.visible = false;
               _txtArrayAdd1.x = maxImagePos[0];
               _txtArrayAdd3.x = maxImagePos[1];
               _txtArrayAdd4.visible = true;
               _btnUpgrade1.enable = true;
            }
         }
         else
         {
            _txtPersent.text = "0/0";
            setExpProgress(0);
            NumberViewUtils.refreshValue(0,spLv1,_numBMD,18,24,15,18,"0123456789");
         }
         _hasGoodsNum = GoodsManager.instance.getGoodsNumByTempId(212034);
         _txtArrayStoneCount.text = _hasGoodsNum + "";
         showSkillTip(_loc1_);
      }
      
      private function setExpProgress(param1:Number) : void
      {
         barMask.width = _bit1.width * param1;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_arrayBg);
         _arrayBg = null;
         ObjectUtils.disposeObject(_btnUpgrade1);
         _btnUpgrade1 = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_txtArrayStoneCount);
         _txtArrayStoneCount = null;
         ObjectUtils.disposeObject(_txtArrayAdd1);
         _txtArrayAdd1 = null;
         ObjectUtils.disposeObject(_txtArrayCostCount);
         _txtArrayCostCount = null;
         ObjectUtils.disposeObject(_txtArrayAdd3);
         _txtArrayAdd3 = null;
         ObjectUtils.disposeObject(_txtArrayAdd2);
         _txtArrayAdd2 = null;
         ObjectUtils.disposeObject(_txtArrayAdd4);
         _txtArrayAdd4 = null;
         ObjectUtils.disposeObject(_txtArrayJian);
         _txtArrayJian = null;
         ObjectUtils.disposeObject(_txtArrayPlayerStr1);
         _txtArrayPlayerStr1 = null;
         ObjectUtils.disposeObject(_txtArrayPlayerStr2);
         _txtArrayPlayerStr2 = null;
         ObjectUtils.disposeObject(_txtArrayPlayerStr3);
         _txtArrayPlayerStr3 = null;
         ObjectUtils.disposeObject(_txtArrayPlayerStr4);
         _txtArrayPlayerStr4 = null;
         ObjectUtils.disposeObject(_txtArrayPlayerValue1);
         _txtArrayPlayerValue1 = null;
         ObjectUtils.disposeObject(_txtArrayPlayerValue2);
         _txtArrayPlayerValue2 = null;
         ObjectUtils.disposeObject(_txtArrayPlayerValue3);
         _txtArrayPlayerValue3 = null;
         ObjectUtils.disposeObject(_txtArrayPlayerValue4);
         _txtArrayPlayerValue4 = null;
         ObjectUtils.disposeObject(_bit3);
         _bit3 = null;
         ObjectUtils.disposeObject(imgStone);
         imgStone = null;
         ObjectUtils.disposeObject(_txtPersent);
         _txtPersent = null;
         ObjectUtils.disposeObject(_levelImage);
         _levelImage = null;
         ObjectUtils.disposeObject(_numBMD);
         _numBMD = null;
         ObjectUtils.disposeObject(spLv1);
         spLv1 = null;
         ObjectUtils.disposeObject(barMask);
         barMask = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_skill1);
         _skill1 = null;
         ObjectUtils.disposeObject(_skill2);
         _skill2 = null;
         ObjectUtils.disposeObject(_skill3);
         _skill3 = null;
         ObjectUtils.disposeObject(_skill4);
         _skill4 = null;
         ObjectUtils.disposeObject(imgMax);
         imgMax = null;
         ObjectUtils.disposeObject(_txtMaxTxt);
         _txtMaxTxt = null;
         ObjectUtils.disposeObject(_imgName);
         _imgName = null;
         ObjectUtils.disposeObject(headCard);
         headCard = null;
         _loc1_ = 0;
         while(_loc1_ < cards.length)
         {
            ObjectUtils.disposeObject(cards[_loc1_]);
            _loc1_++;
         }
         cards = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

