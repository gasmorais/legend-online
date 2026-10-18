package monster
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import monster.item.MonsterCallItemCell;
   import monster.item.MonsterMaterialItemCell;
   import monster.view.MonsterCallDropAreaView;
   import mvc.module.monster.MonsterCallInfo;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.MonsterRecipeTempInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.MonsterManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.PageBar;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterCallFrame extends Frame
   {
      
      private var _materialText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _needText:FilterFrameText;
      
      private var _border:ScaleBitmapImage;
      
      private var _callBtn:IconButton;
      
      private var _callBack:MutipleImage;
      
      private var _bagBorder:ScaleBitmapImage;
      
      private var _pageBar:PageBar;
      
      private var _dropArea:MonsterCallDropAreaView;
      
      private var _materialBox:Component;
      
      private var materialList:Vector.<MonsterCallItemCell>;
      
      private var _tileList:SimpleTileList;
      
      private var itemList:Vector.<MonsterMaterialItemCell>;
      
      private var pageCount:int = 1;
      
      private var materialPosAry:Array = [[19,120],[69,12],[222,12],[271,120],[222,227],[69,226]];
      
      private var data:MonsterCallInfo;
      
      private var needMinCount:int;
      
      public function MonsterCallFrame()
      {
         super();
         initView();
         initPageView();
         initMaterialView();
         initBagView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _materialText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCallFrame.materialText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCallFrame.nameText");
         _needText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCallFrame.needText");
         _border = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCallFrame.border");
         _callBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCallFrame.callBtn");
         _callBack = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCallFrame.callBack");
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("MonsterCallFrame.pageBar");
         _tileList = ComponentFactory.Instance.creatCustomObject("MonsterCallFrame.SimpleTileList",[5]);
         _bagBorder = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterCallFrame.bagBorder");
         _materialBox = ComponentFactory.Instance.creatComponentByStylename("MonsterCallFrame.materialBox");
         _dropArea = ComponentFactory.Instance.creatCustomObject("MonsterCallFrame.dropAreaView");
         addToContent(_border);
         addToContent(_callBack);
         addToContent(_dropArea);
         addToContent(_materialBox);
         addToContent(_nameText);
         addToContent(_needText);
         addToContent(_materialText);
         addToContent(_pageBar);
         addToContent(_bagBorder);
         addToContent(_tileList);
         addToContent(_callBtn);
         _materialBox.mouseEnabled = false;
      }
      
      private function initPageView() : void
      {
         var _loc3_:Array = TempleteManager.instance.monsterRecipeTemplateCate.getRecipeList();
         _pageBar.setAutoPagingData(_loc3_,pageCount);
         _pageBar.setCurPage(1);
         var _loc1_:Array = _pageBar.getCurPageDatas();
         var _loc2_:MonsterRecipeTempInfo = _loc1_[0];
         _nameText.text = _loc2_.Name;
         _materialText.text = _loc2_.Desc;
      }
      
      private function initMaterialView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MonsterCallItemCell = null;
         materialList = new Vector.<MonsterCallItemCell>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("MonsterTrainView.callCell");
            _loc1_.x = materialPosAry[_loc2_][0];
            _loc1_.y = materialPosAry[_loc2_][1];
            _materialBox.addChild(_loc1_);
            materialList.push(_loc1_);
            _loc2_++;
         }
         _materialBox.commitChanges();
      }
      
      private function initBagView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MonsterMaterialItemCell = null;
         itemList = new Vector.<MonsterMaterialItemCell>();
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("MonsterTrainView.BagCell",[3]);
            _tileList.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         _tileList.commitChanges();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _callBtn.addEventListener("click",_callBtnClickHandler);
         _pageBar.addEventListener("change",_pageChangeHandler);
         MsgMan.addObserver("MONSTER_BAG_MOVE",this,__updateMoveHandler);
         MsgMan.addObserver("MONSTER_ITEMMSG_CHANGE",this,__updateMoveHandler);
         MsgMan.addObserver("MONSTER_RECIPE_CHANGE",this,__updateRecipeHandler);
         MsgMan.addObserver("MONSTER_CALL_CHANGE",this,__updateCallStateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_callBtn)
         {
            _callBtn.removeEventListener("click",_callBtnClickHandler);
         }
         if(_pageBar)
         {
            _pageBar.removeEventListener("change",_pageChangeHandler);
         }
         MsgMan.removeObserver("MONSTER_BAG_MOVE",this,__updateMoveHandler);
         MsgMan.removeObserver("MONSTER_ITEMMSG_CHANGE",this,__updateMoveHandler);
         MsgMan.removeObserver("MONSTER_RECIPE_CHANGE",this,__updateRecipeHandler);
         MsgMan.removeObserver("MONSTER_CALL_CHANGE",this,__updateCallStateHandler);
      }
      
      private function __updateCallStateHandler(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      private function __updateRecipeHandler(param1:String, param2:Object) : void
      {
         var _loc3_:Array = _pageBar.getCurPageDatas();
         var _loc4_:MonsterRecipeTempInfo = _loc3_[0];
         _nameText.text = _loc4_.Name;
         _materialText.text = _loc4_.Desc;
      }
      
      private function __updateMoveHandler(param1:String, param2:Object) : void
      {
         refreshBagView();
      }
      
      private function _pageChangeHandler(param1:Event) : void
      {
         var _loc2_:Array = _pageBar.getCurPageDatas();
         var _loc3_:MonsterRecipeTempInfo = _loc2_[0];
         _nameText.text = _loc3_.Name;
         _materialText.text = _loc3_.Desc;
      }
      
      private function _callBtnClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         var _loc2_:Array = model.getMaterialIds(model.callMaterialList);
         if(_loc2_.length < needMinCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mvc.module.children.ChildSender.pickChildCall.goldNotEnough5"));
            return;
         }
         MonsterManager.instance.sendMonsterCall(data.index,_loc2_);
      }
      
      private function refreshView() : void
      {
         refreshBagView();
      }
      
      private function refreshBagView() : void
      {
         var _loc3_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc6_:GoodsInfo = null;
         clearBagView();
         var _loc1_:Array = model.callBagDic.getList();
         _loc1_.sortOn("templateId",16);
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc5_ = _loc1_[_loc3_] as GoodsInfo;
            itemList[_loc3_].data = _loc5_;
            _loc3_++;
         }
         _tileList.commitChanges();
         var _loc2_:Array = model.callMaterialList;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc4_] as GoodsInfo;
            materialList[_loc4_].data = _loc6_;
            _loc4_++;
         }
      }
      
      private function clearBagView() : void
      {
         for each(var _loc1_:MonsterCallItemCell in materialList)
         {
            _loc1_.data = null;
         }
         for each(var _loc2_:MonsterMaterialItemCell in itemList)
         {
            _loc2_.data = null;
         }
      }
      
      public function setCallInfo(param1:MonsterCallInfo) : void
      {
         data = param1;
         if(!data)
         {
            return;
         }
         var _loc2_:Array = ConfigInfoManager.instance.getMonsterCallConifg();
         var _loc3_:Array = _loc2_[data.level - 1].split(",");
         needMinCount = _loc3_[0];
         _needText.text = LanguageMgr.GetTranslation("MonsterCallFrame.needText.text",needMinCount);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("ChildHandBookItem.callBtn.text");
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = false;
         model.resetCallBagList();
         ObjectUtils.disposeObject(_materialText);
         _materialText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_needText);
         _needText = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_callBtn);
         _callBtn = null;
         ObjectUtils.disposeObject(_callBack);
         _callBack = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         ObjectUtils.disposeObject(_tileList);
         _tileList = null;
         ObjectUtils.disposeObject(_materialBox);
         _materialBox = null;
         ObjectUtils.disposeObject(_bagBorder);
         _bagBorder = null;
         ObjectUtils.disposeObject(_dropArea);
         _dropArea = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         LogicUtils.disposeDisplayCollection(materialList);
         materialList = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

