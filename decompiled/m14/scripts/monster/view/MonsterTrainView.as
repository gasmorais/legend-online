package monster.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import monster.MonsterEvolveFrame;
   import monster.MonsterKitchenFrame;
   import monster.item.MonsterMaterialItemCell;
   import monster.item.MonsterTrainItem;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.MonsterManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.ProgressCommon;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterTrainView extends Component
   {
      
      private var _goldText:FilterFrameText;
      
      private var _rateText:FilterFrameText;
      
      private var _arrowImage2:Image;
      
      private var _nextAddImage:MutipleImage;
      
      private var _nextItem:MonsterTrainItem;
      
      private var _curItem:MonsterTrainItem;
      
      private var _mBack:MutipleImage;
      
      private var _evolveBtn:IconButton;
      
      private var _trainBtn:IconButton;
      
      private var _trainNumBit:BitmapData;
      
      private var _curPeriodCon:Component;
      
      private var _nextPeriodCon:Component;
      
      private var _fullText:FilterFrameText;
      
      private var _rateMc:MovieClip;
      
      private var _rateMcMask:Component;
      
      private var _expBar:ProgressCommon;
      
      private var _rateBar:ProgressCommon;
      
      private var _rateItemHbox:HBox;
      
      private var rateList:Vector.<MonsterMaterialItemCell>;
      
      private var _list:SimpleTileList;
      
      private var _bagScroll:ScrollPanel;
      
      private var bagList:Vector.<MonsterMaterialItemCell>;
      
      private var row:int = 14;
      
      private var col:int = 5;
      
      private var _cookFrame:MonsterKitchenFrame;
      
      private var needGold:Number;
      
      public function MonsterTrainView()
      {
         super();
         initView();
         initRateBoxView();
         initBagView();
         addEvent();
         showCookFrame();
         refreshView();
         refreshBagView();
      }
      
      private function initView() : void
      {
         _goldText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterTrailView.goldText");
         _rateText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterTrailView.rateText");
         _arrowImage2 = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterTrailView.arrowImage2");
         _nextAddImage = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterTrailView.nextAddImage");
         _nextItem = ComponentFactory.Instance.creatCustomObject("Monster.MonsterTrailView.nextItem");
         _curItem = ComponentFactory.Instance.creatCustomObject("Monster.MonsterTrailView.curItem");
         _mBack = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterTrailView.mBack");
         _evolveBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterTrailView.evolveBtn");
         _trainBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterTrailView.trainBtn");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterTrailView.expBar");
         _rateBar = ComponentFactory.Instance.creatComponentByStylename("MonsterTrailView.rateBar");
         _trainNumBit = ComponentFactory.Instance.creatBitmapData("asset.MonsterTrailView.trainNumBit");
         _curPeriodCon = ComponentFactory.Instance.creatComponentByStylename("MonsterTrailView.curPeriodCon");
         _nextPeriodCon = ComponentFactory.Instance.creatComponentByStylename("MonsterTrailView.nextPeriodCon");
         _rateItemHbox = ComponentFactory.Instance.creatComponentByStylename("MonsterTrailView.rateItemHbox");
         _fullText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterTrainItem.fullText");
         _rateMc = ComponentFactory.Instance.creatCustomObject("MonsterTrainView.rateMc");
         _list = ComponentFactory.Instance.creatCustomObject("MonsterTrainView.SimpleTileList",[col]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("MonsterTrainView.EquipScrollPanel");
         _rateMcMask = ComponentFactory.Instance.creatComponentByStylename("MonsterTrainView.rateMcMask");
         addChild(_mBack);
         addChild(_curItem);
         addChild(_nextItem);
         addChild(_nextAddImage);
         addChild(_arrowImage2);
         addChild(_fullText);
         addChild(_goldText);
         addChild(_curPeriodCon);
         addChild(_nextPeriodCon);
         addChild(_expBar);
         addChild(_rateMc);
         addChild(_rateMcMask);
         addChild(_rateBar);
         addChild(_rateText);
         addChild(_rateItemHbox);
         addChild(_bagScroll);
         addChild(_trainBtn);
         addChild(_evolveBtn);
         _bagScroll.setView(_list);
         _rateText.text = LanguageMgr.GetTranslation("MonsterTrailView.rateText.text");
         this.mouseEnabled = false;
         setRateMcMask(false,0,0,0,0);
         _rateMc.mask = _rateMcMask;
      }
      
      private function setRateMcMask(param1:Boolean, param2:int, param3:int, param4:int, param5:int) : void
      {
         if(param1)
         {
            _rateMc.gotoAndPlay(1);
         }
         else
         {
            _rateMc.gotoAndStop(1);
         }
         _rateMcMask.graphics.clear();
         _rateMcMask.graphics.beginFill(16777215,1);
         _rateMcMask.graphics.drawRect(param2,param3,param4,param5);
         _rateMcMask.graphics.endFill();
      }
      
      private function initRateBoxView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MonsterMaterialItemCell = null;
         rateList = new Vector.<MonsterMaterialItemCell>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("MonsterTrainView.BagCell",[2]);
            _rateItemHbox.addChild(_loc1_);
            rateList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initBagView() : void
      {
         var _loc2_:* = 0;
         var _loc1_:MonsterMaterialItemCell = null;
         bagList = new Vector.<MonsterMaterialItemCell>();
         _list.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 70)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("MonsterTrainView.BagCell",[1]);
            _loc1_.pos = -1;
            _list.addChild(_loc1_);
            bagList.push(_loc1_);
            _loc2_++;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         _trainBtn.addEventListener("click",_trainBtnClickHandler);
         _evolveBtn.addEventListener("click",_evolveBtnClickHandler);
         MsgMan.addObserver("MONSTER_BAG_MOVE",this,__updateMoveHandler);
         MsgMan.addObserver("MONSTER_INFO_CHANGE",this,__updateMonsterListHandler);
         MsgMan.addObserver("MONSTER_USER_INFO_CHANGE",this,__updateItemListHandler);
         MsgMan.addObserver("MONSTER_ITEMMSG_CHANGE",this,__updateItemListHandler);
         MsgMan.addObserver("MONSTER_ITEM_SELECT",this,__updateSelectHandler);
      }
      
      private function removeEvent() : void
      {
         if(_trainBtn)
         {
            _trainBtn.removeEventListener("click",_trainBtnClickHandler);
         }
         if(_evolveBtn)
         {
            _evolveBtn.removeEventListener("click",_evolveBtnClickHandler);
         }
         MsgMan.removeObserver("MONSTER_BAG_MOVE",this,__updateMoveHandler);
         MsgMan.removeObserver("MONSTER_INFO_CHANGE",this,__updateMonsterListHandler);
         MsgMan.removeObserver("MONSTER_USER_INFO_CHANGE",this,__updateItemListHandler);
         MsgMan.removeObserver("MONSTER_ITEMMSG_CHANGE",this,__updateItemListHandler);
         MsgMan.removeObserver("MONSTER_ITEM_SELECT",this,__updateSelectHandler);
      }
      
      private function __updateSelectHandler(param1:String, param2:Object) : void
      {
         refreshView();
         refreshBagView();
      }
      
      private function __updateMonsterListHandler(param1:String, param2:Object) : void
      {
         refreshView();
         refreshBagView();
      }
      
      private function __updateItemListHandler(param1:String, param2:Object) : void
      {
         refreshView();
         refreshBagView();
      }
      
      private function __updateMoveHandler(param1:String, param2:Object) : void
      {
         refreshView();
         refreshBagView();
      }
      
      private function _trainBtnClickHandler(param1:MouseEvent) : void
      {
         if(!model.selectMonster)
         {
            return;
         }
         if(model.selectMonster.stageGrade >= model.selectMonster.star)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterTrainView.train.stageFullAlert"));
            return;
         }
         var _loc2_:Array = model.getMaterialIds(model.rateBagList);
         if(_loc2_.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         if(ResourceManager.instance.gold.count < needGold)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.gold"));
            return;
         }
         MonsterManager.instance.sendMonsterTrain(model.selectMonster.monsterId,_loc2_);
      }
      
      private function _evolveBtnClickHandler(param1:MouseEvent) : void
      {
         if(!model.checkCanEvolve(model.selectMonster))
         {
            return;
         }
         var _loc2_:MonsterEvolveFrame = ComponentFactory.Instance.creatComponentByStylename("monster.MonsterEvolveFrame");
         _loc2_.data = model.selectMonster;
         _loc2_.show();
      }
      
      private function refreshView() : void
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc9_:int = 0;
         var _loc1_:Number = NaN;
         var _loc3_:Number = NaN;
         if(!model.selectMonster)
         {
            return;
         }
         _curItem.data = model.selectMonster;
         NumberViewUtils.refreshValue(model.selectMonster.stageGrade,_curPeriodCon,_trainNumBit,16,21,13,16,"0123456789");
         var _loc7_:UpgradeTemplateInfo = model.stageUpgradeTempAry[model.selectMonster.stageGrade];
         var _loc5_:int = int(model.selectMonster.stageExp);
         var _loc2_:Number = Number(model.getRateByMaterials(model.rateBagList));
         _rateBar.text = model.getRateByMaterials(model.rateBagList) + "%";
         _rateBar.value = int(_loc2_) < 100 ? model.getRateByMaterials(model.rateBagList) / 100 : 1;
         needGold = model.getTrainNeedGold(model.rateBagList);
         _goldText.text = needGold + "";
         setRateMcMask(false,0,0,0,0);
         if(model.rateBagList.length <= 0)
         {
            _trainBtn.enable = false;
            _nextAddImage.visible = _arrowImage2.visible = false;
            _nextPeriodCon.visible = false;
            _nextItem.data = null;
            _expBar.text = model.selectMonster.stageExp + "/" + _loc7_.Data;
            _expBar.value = model.selectMonster.stageExp / _loc7_.Data;
         }
         else
         {
            _trainBtn.enable = true;
            _nextAddImage.visible = _arrowImage2.visible = true;
            _nextPeriodCon.visible = true;
            _loc8_ = int(model.trainTotalExp(_loc5_,model.rateBagList));
            _loc6_ = int(TempleteManager.instance.getUpgradeTempMaxGradeByType(148));
            _loc4_ = TempleteManager.instance.getUpgradeTotalInfo(148,_loc8_,_loc7_.Grades,_loc6_);
            _loc9_ = int(_loc4_[1]);
            NumberViewUtils.refreshValue(_loc9_,_nextPeriodCon,_trainNumBit,16,21,13,16,"0123456789");
            _nextItem.data = copyNextMonsterInfo(model.selectMonster,_loc9_);
            if(_loc9_ <= _loc7_.Grades)
            {
               _nextAddImage.visible = _arrowImage2.visible = false;
               _nextPeriodCon.visible = false;
               _nextItem.data = null;
               _expBar.text = _loc8_ + "/" + _loc7_.Data;
               _expBar.value = _loc8_ / int(_loc7_.Data);
            }
            else if(_loc9_ >= model.selectMonster.star)
            {
               _expBar.text = LanguageMgr.GetTranslation("card.CardBagCell.expMax");
               _expBar.value = _loc8_ / _loc7_.Data;
            }
            else
            {
               _expBar.text = _loc4_[2] + "/" + _loc4_[3];
               _expBar.value = int(_loc4_[2]) / int(_loc4_[3]);
            }
         }
         if(_loc2_ > 0 && _loc9_ < model.selectMonster.star)
         {
            _loc1_ = 288 * (int(_loc4_[2]) / int(_loc4_[3]));
            _loc3_ = 288 * (_loc8_ - _loc5_) / int(_loc4_[3]);
            setRateMcMask(true,_loc1_,0,_loc3_,15);
         }
         if(model.selectMonster.stageGrade >= model.selectMonster.star)
         {
            _fullText.text = LanguageMgr.GetTranslation("consortia.ConsortiaControler.command09");
            _expBar.text = LanguageMgr.GetTranslation("card.CardBagCell.expMax");
            _expBar.value = 1;
         }
         else
         {
            _fullText.text = "";
         }
      }
      
      private function refreshBagView() : void
      {
         var _loc2_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc3_:int = 0;
         var _loc6_:GoodsInfo = null;
         clearBagView();
         var _loc1_:Array = model.trainBagDic.getList();
         _loc1_.sortOn("templateId",16);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc5_ = _loc1_[_loc2_] as GoodsInfo;
            bagList[_loc2_].data = _loc5_;
            _loc2_++;
         }
         _bagScroll.invalidateViewport();
         var _loc4_:Array = model.rateBagList;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc3_] as GoodsInfo;
            rateList[_loc3_].data = _loc6_;
            _loc3_++;
         }
         _bagScroll.invalidateViewport();
      }
      
      private function copyNextMonsterInfo(param1:MonsterInfo, param2:int) : MonsterInfo
      {
         var _loc3_:MonsterInfo = new MonsterInfo();
         _loc3_.type = param1.type;
         _loc3_.star = param1.star;
         _loc3_.name = param1.name;
         _loc3_.grade = param1.grade;
         _loc3_.stageGrade = param2;
         return _loc3_;
      }
      
      private function clearBagView() : void
      {
         for each(var _loc1_:MonsterMaterialItemCell in bagList)
         {
            _loc1_.data = null;
         }
         for each(var _loc2_:MonsterMaterialItemCell in rateList)
         {
            _loc2_.data = null;
         }
      }
      
      private function showCookFrame() : void
      {
         if(!_cookFrame)
         {
            _cookFrame = ComponentFactory.Instance.creatComponentByStylename("monster.MonsterKitchenFrame");
         }
         if(_cookFrame && !_cookFrame.parent)
         {
            addChild(_cookFrame);
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         model.resetBagList();
         ObjectUtils.disposeObject(_goldText);
         _goldText = null;
         ObjectUtils.disposeObject(_rateItemHbox);
         _rateItemHbox = null;
         ObjectUtils.disposeObject(_rateText);
         _rateText = null;
         ObjectUtils.disposeObject(_arrowImage2);
         _arrowImage2 = null;
         ObjectUtils.disposeObject(_nextAddImage);
         _nextAddImage = null;
         ObjectUtils.disposeObject(_nextItem);
         _nextItem = null;
         ObjectUtils.disposeObject(_curItem);
         _curItem = null;
         ObjectUtils.disposeObject(_mBack);
         _mBack = null;
         ObjectUtils.disposeObject(_evolveBtn);
         _evolveBtn = null;
         ObjectUtils.disposeObject(_trainBtn);
         _trainBtn = null;
         ObjectUtils.disposeObject(_curPeriodCon);
         _curPeriodCon = null;
         ObjectUtils.disposeObject(_nextPeriodCon);
         _nextPeriodCon = null;
         ObjectUtils.disposeObject(_trainNumBit);
         _trainNumBit = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeObject(_rateBar);
         _rateBar = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_bagScroll);
         _bagScroll = null;
         LogicUtils.disposeDisplayCollection(rateList);
         rateList = null;
         LogicUtils.disposeDisplayCollection(bagList);
         bagList = null;
         ObjectUtils.disposeObject(_cookFrame);
         _cookFrame = null;
         ObjectUtils.disposeObject(_fullText);
         _fullText = null;
         ObjectUtils.disposeViolentMc(_rateMc);
         _rateMc = null;
         ObjectUtils.disposeObject(_rateMcMask);
         _rateMcMask = null;
         super.dispose();
      }
   }
}

