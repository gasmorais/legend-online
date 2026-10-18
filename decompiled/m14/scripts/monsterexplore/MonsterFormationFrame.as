package monsterexplore
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import monsterexplore.item.MonsterFormationItemView;
   import monsterexplore.item.MonsterFormationSelectItem;
   import mvc.ModuleFrameInfo;
   import mvc.module.monster.MonsterModel;
   import mvc.module.monsterexplore.MonsterExploreFormationInfo;
   import mvc.module.monsterexplore.MonsterExploreModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.DragManager;
   import yishi.manager.MonsterExploreManager;
   import yishi.manager.MonsterManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.MsgMan;
   
   public class MonsterFormationFrame extends Frame
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _back:MutipleImage;
      
      private var _hbox:HBox;
      
      private var monsterList:Vector.<MonsterFormationSelectItem>;
      
      private var _bottoms:Array;
      
      private var monsterLen:int = 3;
      
      private var posAry:Array = [3,6,9,12,1,4,7,10];
      
      private var posArray:Array = [[],[1,3],[4,6],[7,9],[10,12]];
      
      public function MonsterFormationFrame()
      {
         super();
         initView();
         initListView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,500,456);
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:MonsterFormationItemView = null;
         _border = ComponentFactory.Instance.creatComponentByStylename("MonsterFormationFrame.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("MonsterFormationFrame.back");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("MonsterFormationFrame.hbox");
         addToContent(_border);
         addToContent(_back);
         addToContent(_hbox);
         _bottoms = [];
         var _loc1_:Array = [{
            "x":326,
            "y":196
         },{
            "x":284,
            "y":254
         },{
            "x":241,
            "y":306
         },{
            "x":191,
            "y":356
         },{
            "x":535,
            "y":196
         },{
            "x":497,
            "y":254
         },{
            "x":451,
            "y":306
         },{
            "x":401,
            "y":356
         }];
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc2_ = new MonsterFormationItemView(posAry[_loc3_]);
            _loc2_.x = _loc1_[_loc3_].x;
            _loc2_.y = _loc1_[_loc3_].y;
            addToContent(_loc2_);
            _bottoms[_loc3_] = _loc2_;
            _loc3_++;
         }
         this.titleText = LanguageMgr.GetTranslation("PetFormationFrame.title");
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MonsterFormationSelectItem = null;
         monsterList = new Vector.<MonsterFormationSelectItem>();
         _loc2_ = monsterLen;
         while(_loc2_ > 0)
         {
            _loc1_ = new MonsterFormationSelectItem(_loc2_);
            _hbox.addChild(_loc1_);
            monsterList.push(_loc1_);
            _loc2_--;
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("FORMATION_SERVER_BACK",this,__formationChangeHandler);
         NotificationManager.instance.addEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.addEventListener("END_DRAG",__endDragHandler);
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("EXPLORE_HEAD_CHANGE",this,__selectMonsterHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("FORMATION_SERVER_BACK",this,__formationChangeHandler);
         NotificationManager.instance.removeEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.removeEventListener("END_DRAG",__endDragHandler);
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("EXPLORE_HEAD_CHANGE",this,__selectMonsterHandler);
      }
      
      private function __selectMonsterHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __formationChangeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __startDragHandler(param1:NotificationEvent) : void
      {
         var _loc4_:int = 0;
         if(param1.data && param1.data.data && param1.data.data.monsterId)
         {
            _loc4_ = int(param1.data.data.monsterId);
         }
         var _loc2_:Array = getCanNotDrops(_loc4_);
         for each(var _loc3_:MonsterFormationItemView in _bottoms)
         {
            if(_loc2_.indexOf(_loc3_.pos) == -1)
            {
               _loc3_.setBottomVisible(true);
               _loc3_.dark();
            }
         }
      }
      
      private function __endDragHandler(param1:NotificationEvent) : void
      {
         var _loc3_:MonsterExploreFormationInfo = null;
         for each(var _loc2_:MonsterFormationItemView in _bottoms)
         {
            _loc2_.setBottomVisible(false);
            _loc2_.normal();
            if(_loc2_.data)
            {
               _loc3_ = exploreModel.formationDic[_loc2_.data.monsterId];
               if(_loc3_)
               {
                  _loc3_.fightPos = _loc2_.pos;
               }
            }
         }
      }
      
      private function getCanNotDrops(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         for each(var _loc3_:MonsterFormationItemView in _bottoms)
         {
            if(_loc3_.data && _loc3_.data.monsterId != param1)
            {
               _loc4_ = Math.ceil(_loc3_.pos / 3);
               _loc2_ = _loc2_.concat(posArray[_loc4_]);
            }
         }
         return _loc2_;
      }
      
      private function refreshView() : void
      {
         refreshItemView();
         refreshFormationView();
      }
      
      private function refreshFormationView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:MonsterFormationItemView = null;
         var _loc2_:MonsterExploreFormationInfo = null;
         _loc3_ = 0;
         while(_loc3_ < _bottoms.length)
         {
            _loc1_ = _bottoms[_loc3_];
            _loc2_ = exploreModel.getFormationInfoByFightPos(_loc1_.pos);
            _loc1_.data = _loc2_;
            _loc3_++;
         }
      }
      
      private function refreshItemView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:MonsterFormationSelectItem = null;
         var _loc2_:MonsterExploreFormationInfo = null;
         _loc3_ = monsterLen;
         while(_loc3_ > 0)
         {
            _loc1_ = monsterList[monsterLen - _loc3_];
            _loc2_ = exploreModel.getFormationInfoByIndex(_loc3_);
            _loc1_.data = _loc2_;
            _loc3_--;
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      private function get exploreModel() : MonsterExploreModel
      {
         return MonsterExploreManager.instance.model;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         DragManager.getInstance().stopDrag();
         KeyBoardRegister.instance.keyEnable = true;
         if(!exploreModel.checkFormationDicIsSame())
         {
            MonsterExploreManager.instance.sendMonsterFormation(exploreModel.formationDic);
         }
         exploreModel.copyFormationDicData();
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         LogicUtils.disposeDisplayCollection(_bottoms);
         _bottoms = null;
         LogicUtils.disposeDisplayCollection(monsterList);
         super.dispose();
      }
   }
}

