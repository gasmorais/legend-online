package sort.shoubang
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.controler.SortController;
   import mvc.module.sort.SortData;
   import mvc.module.sort.SortModel;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   
   public class ShouBangFrame extends Frame
   {
      
      private var _c:Sprite;
      
      private var _bg1:DisplayObject;
      
      private var _bg:DisplayObject;
      
      private const HEAD_POS:Array = [[304,123],[158,56],[177,253],[37,155],[436,208],[544,114]];
      
      private var _model:SortModel;
      
      private var _controller:SortController;
      
      private var _head1:ShouBangItem;
      
      private var _head2:ShouBangItem;
      
      private var _head3:ShouBangItem;
      
      private var _head4:ShouBangItem;
      
      private var _head5:ShouBangItem;
      
      private var _head6:ShouBangItem;
      
      private var _btnLocal:SelectedButton;
      
      private var _btnCross:SelectedButton;
      
      private var _btnRegress:SelectedButton;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _btnShowTotal:IconButton;
      
      private var _isCross:Boolean = false;
      
      public function ShouBangFrame()
      {
         super();
         _controller = FrameControllerManager.instance.sortController;
         _model = _controller.model;
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         _titleText = LanguageMgr.GetTranslation("sort.shoubang.frametitle");
         _bg1 = ComponentFactory.Instance.creat("shoubang.dibg");
         _bg1.x = 3;
         _bg1.y = 9;
         this.addToContent(_bg1);
         _c = new Sprite();
         _c.x = 8;
         _c.y = 12;
         this.addToContent(_c);
         _bg = ComponentFactory.Instance.creat("asset.shoubang.bg");
         _c.addChild(_bg);
         _btnLocal = ComponentFactory.Instance.creatComponentByStylename("sort.shoubang.localBtn");
         _c.addChild(_btnLocal);
         _btnCross = ComponentFactory.Instance.creatComponentByStylename("sort.shoubang.crossBtn");
         _c.addChild(_btnCross);
         _btnRegress = ComponentFactory.Instance.creatComponentByStylename("sort.shoubang.regressBtn");
         _c.addChild(_btnRegress);
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(_btnLocal);
         _buttonGroup.addSelectItem(_btnCross);
         _buttonGroup.addSelectItem(_btnRegress);
         _buttonGroup.selectIndex = 0;
         _btnShowTotal = ComponentFactory.Instance.creatComponentByStylename("sort.numberone.btntotal");
         _c.addChild(_btnShowTotal);
         initHead();
         updateData();
      }
      
      private function initHead() : void
      {
         _head1 = new ShouBangItem();
         _head1.x = HEAD_POS[0][0];
         _head1.y = HEAD_POS[0][1];
         _c.addChild(_head1);
         _head2 = new ShouBangItem();
         _head2.x = HEAD_POS[1][0];
         _head2.y = HEAD_POS[1][1];
         _c.addChild(_head2);
         _head3 = new ShouBangItem();
         _head3.x = HEAD_POS[2][0];
         _head3.y = HEAD_POS[2][1];
         _c.addChild(_head3);
         _head4 = new ShouBangItem();
         _head4.x = HEAD_POS[3][0];
         _head4.y = HEAD_POS[3][1];
         _c.addChild(_head4);
         _head5 = new ShouBangItem();
         _head5.x = HEAD_POS[4][0];
         _head5.y = HEAD_POS[4][1];
         _c.addChild(_head5);
         _head6 = new ShouBangItem();
         _head6.x = HEAD_POS[5][0];
         _head6.y = HEAD_POS[5][1];
         _c.addChild(_head6);
      }
      
      private function addEvents() : void
      {
         addEventListener("response",__frameResponse);
         _buttonGroup.addEventListener("change",__onChangeHandler);
         _btnShowTotal.addEventListener("click",showTotalHandler);
      }
      
      protected function showTotalHandler(param1:Event) : void
      {
         dispose();
         FrameControllerManager.instance.openControllerByInfo("sort");
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__frameResponse);
         _buttonGroup.removeEventListener("change",__onChangeHandler);
         _btnShowTotal.removeEventListener("click",showTotalHandler);
      }
      
      private function __onChangeHandler(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         SoundManager.instance.play("022");
         var _loc5_:ISelectable = _buttonGroup.getSelectedItem();
         var _loc2_:Array = [];
         switch(_loc5_)
         {
            case _btnLocal:
               _isCross = false;
               if(_model.playerFightList == null || _model.playerFightList.length == 0)
               {
                  _loc3_ = PathManager.orderPath + "fight.xml";
                  _loc2_.push(_loc3_);
               }
               if(_model.accumulationAddList == null || _model.accumulationAddList.length == 0)
               {
                  _loc3_ = PathManager.orderPath + "total.xml";
                  _loc2_.push(_loc3_);
               }
               if(_model.playerHonourList == null || _model.playerHonourList.length == 0)
               {
                  _loc3_ = PathManager.orderPath + "geste.xml";
                  _loc2_.push(_loc3_);
               }
               if(_model.charmsTotalAddList == null || _model.charmsTotalAddList.length == 0)
               {
                  _loc3_ = PathManager.orderPath + "totalcharm.xml";
                  _loc2_.push(_loc3_);
               }
               if(_model.soulScoreTotalAddList == null || _model.soulScoreTotalAddList.length == 0)
               {
                  _loc3_ = PathManager.orderPath + "soulscore.xml";
                  _loc2_.push(_loc3_);
               }
               if(_model.petPowerList == null || _model.petPowerList.length == 0)
               {
                  _loc3_ = PathManager.orderPath + "petfightcapacityrank.xml";
                  _loc2_.push(_loc3_);
               }
               if(_loc2_.length > 0)
               {
                  _controller.loadAllLocalXML(_loc2_,updateData);
               }
               else
               {
                  updateData();
               }
               break;
            case _btnCross:
               _isCross = true;
               _loc2_ = [];
               if(_model.playerFightList2 == null || _model.playerFightList2.length == 0)
               {
                  _loc3_ = PathManager.orderPath + "cross/fight.xml";
                  _loc2_.push(_loc3_);
               }
               if(_model.accumulationAddList2 == null || _model.accumulationAddList2.length == 0)
               {
                  _loc3_ = PathManager.orderPath + "cross/total.xml";
                  _loc2_.push(_loc3_);
               }
               if(_model.playerHonourList2 == null || _model.playerHonourList2.length == 0)
               {
                  _loc3_ = PathManager.orderPath + "cross/geste.xml";
                  _loc2_.push(_loc3_);
               }
               if(_model.charmsTotalAddList2 == null || _model.charmsTotalAddList2.length == 0)
               {
                  _loc3_ = PathManager.orderPath + "cross/totalcharm.xml";
                  _loc2_.push(_loc3_);
               }
               if(_model.soulScoreTotalAddList2 == null || _model.soulScoreTotalAddList2.length == 0)
               {
                  _loc3_ = PathManager.orderPath + "cross/soulscore.xml";
                  _loc2_.push(_loc3_);
               }
               if(_model.petPowerList2 == null || _model.petPowerList2.length == 0)
               {
                  _loc3_ = PathManager.orderPath + "cross/petfightcapacityrank.xml";
                  _loc2_.push(_loc3_);
               }
               if(_loc2_.length > 0)
               {
                  _controller.loadAllCrossXML(_loc2_,updateData);
               }
               else
               {
                  updateData();
               }
               break;
            case _btnRegress:
               _model.currentSelected = 12;
               dispose();
               FrameControllerManager.instance.openControllerByInfo("sort");
         }
      }
      
      private function updateData() : void
      {
         var _loc1_:SortData = null;
         if(_isCross)
         {
            if(_model.playerFightList2 && _model.playerFightList2.length > 0)
            {
               _loc1_ = _model.playerFightList2[0];
               _head1.updateData(_loc1_,1);
            }
            else
            {
               _head1.blankHead(1);
            }
            if(_model.accumulationAddList2 && _model.accumulationAddList2.length > 0)
            {
               _loc1_ = _model.accumulationAddList2[0];
               _head2.updateData(_loc1_,2);
            }
            else
            {
               _head2.blankHead(2);
            }
            if(_model.playerHonourList2 && _model.playerHonourList2.length > 0)
            {
               _loc1_ = _model.playerHonourList2[0];
               _head3.updateData(_loc1_,3);
            }
            else
            {
               _head3.blankHead(3);
            }
            if(_model.charmsTotalAddList2 && _model.charmsTotalAddList2.length > 0)
            {
               _loc1_ = _model.charmsTotalAddList2[0];
               _head4.updateData(_loc1_,4);
            }
            else
            {
               _head4.blankHead(4);
            }
            if(_model.soulScoreTotalAddList2 && _model.soulScoreTotalAddList2.length > 0)
            {
               _loc1_ = _model.soulScoreTotalAddList2[0];
               _head5.updateData(_loc1_,5);
            }
            else
            {
               _head5.blankHead(5);
            }
            if(_model.petPowerList2 && _model.petPowerList2.length > 0)
            {
               _loc1_ = _model.petPowerList2[0];
               _head6.updateData(_loc1_,6);
            }
            else
            {
               _head6.blankHead(6);
            }
            return;
         }
         if(_model.playerFightList && _model.playerFightList.length > 0)
         {
            _loc1_ = _model.playerFightList[0];
            _head1.updateData(_loc1_,1);
         }
         else
         {
            _head1.blankHead(1);
         }
         if(_model.accumulationAddList && _model.accumulationAddList.length > 0)
         {
            _loc1_ = _model.accumulationAddList[0];
            _head2.updateData(_loc1_,2);
         }
         else
         {
            _head2.blankHead(2);
         }
         if(_model.playerHonourList && _model.playerHonourList.length > 0)
         {
            _loc1_ = _model.playerHonourList[0];
            _head3.updateData(_loc1_,3);
         }
         else
         {
            _head3.blankHead(3);
         }
         if(_model.charmsTotalAddList && _model.charmsTotalAddList.length > 0)
         {
            _loc1_ = _model.charmsTotalAddList[0];
            _head4.updateData(_loc1_,4);
         }
         else
         {
            _head4.blankHead(4);
         }
         if(_model.soulScoreTotalAddList && _model.soulScoreTotalAddList.length > 0)
         {
            _loc1_ = _model.soulScoreTotalAddList[0];
            _head5.updateData(_loc1_,5);
         }
         else
         {
            _head5.blankHead(5);
         }
         if(_model.petPowerList && _model.petPowerList.length > 0)
         {
            _loc1_ = _model.petPowerList[0];
            _head6.updateData(_loc1_,6);
         }
         else
         {
            _head6.blankHead(6);
         }
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
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvents();
         if(_model)
         {
            _model.cleanData();
            _model = null;
         }
         _controller = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_c);
         _c = null;
         ObjectUtils.disposeObject(_head1);
         _head1 = null;
         ObjectUtils.disposeObject(_head2);
         _head2 = null;
         ObjectUtils.disposeObject(_head3);
         _head3 = null;
         ObjectUtils.disposeObject(_head4);
         _head4 = null;
         ObjectUtils.disposeObject(_head5);
         _head5 = null;
         ObjectUtils.disposeObject(_head6);
         _head6 = null;
         ObjectUtils.disposeObject(_btnLocal);
         _btnLocal = null;
         ObjectUtils.disposeObject(_btnCross);
         _btnCross = null;
         ObjectUtils.disposeObject(_buttonGroup);
         _buttonGroup = null;
         ObjectUtils.disposeObject(_btnShowTotal);
         _btnShowTotal = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

