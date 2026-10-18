package monsterexplore.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import monsterexplore.view.MonsterExploreHeadSelectView;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import mvc.module.monsterexplore.MonsterExploreFormationInfo;
   import mvc.module.monsterexplore.MonsterExploreModel;
   import yishi.manager.MonsterExploreManager;
   import yishi.manager.MonsterManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterFormationSelectItem extends Component
   {
      
      private var _headCon:Component;
      
      private var _back:Bitmap;
      
      private var _headIcon:BaseIconView;
      
      private var _addImage:Bitmap;
      
      private var _delBtn:BaseButton;
      
      private var _captainBit:Bitmap;
      
      private var _setCaptainBtn:TextButton;
      
      private var _data:MonsterExploreFormationInfo;
      
      private var monsterInfo:MonsterInfo;
      
      private var index:int;
      
      private var _selectMonsterView:MonsterExploreHeadSelectView;
      
      public function MonsterFormationSelectItem(param1:int)
      {
         super();
         index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _headCon = ComponentFactory.Instance.creatComponentByStylename("MonsterFormationSelectItem.headCon");
         _back = ComponentFactory.Instance.creatBitmap("asset.MonsterFormationSelectItem.back");
         _headIcon = ComponentFactory.Instance.creatCustomObject("MonsterFormationSelectItem.headIcon");
         _addImage = ComponentFactory.Instance.creatBitmap("asset.MonsterFormationSelectItem.add");
         _delBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterFormationSelectItem.delBtn");
         _captainBit = ComponentFactory.Instance.creatBitmap("asset.MonsterFormationSelectItem.captainBit");
         _setCaptainBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterFormationSelectItem.setCaptainBtn");
         addChild(_headCon);
         addChild(_setCaptainBtn);
         _headCon.addChild(_addImage);
         _headCon.addChild(_headIcon);
         _headCon.addChild(_back);
         _headCon.addChild(_captainBit);
         _headCon.addChild(_delBtn);
         this.buttonMode = true;
         _delBtn.visible = false;
         _captainBit.visible = false;
         _setCaptainBtn.visible = false;
         _setCaptainBtn.text = LanguageMgr.GetTranslation("MonsterFormationSelectItem.setCaptainBtn.text");
      }
      
      private function addEvent() : void
      {
         _headCon.addEventListener("mouseOver",__mouseOverHandler);
         _headCon.addEventListener("mouseOut",__mouseOutHandler);
         _headCon.addEventListener("click",__selectClickHandler);
         _delBtn.addEventListener("click",__delClickHandler);
         _setCaptainBtn.addEventListener("click",__setCaptainHandler);
      }
      
      private function removeEvent() : void
      {
         if(_headCon)
         {
            removeEventListener("mouseOver",__mouseOverHandler);
         }
         if(_headCon)
         {
            removeEventListener("mouseOut",__mouseOutHandler);
         }
         if(_headCon)
         {
            removeEventListener("click",__selectClickHandler);
         }
         if(_delBtn)
         {
            _delBtn.removeEventListener("click",__delClickHandler);
         }
         if(_setCaptainBtn)
         {
            _setCaptainBtn.removeEventListener("click",__setCaptainHandler);
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _delBtn.visible = false;
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(data)
         {
            _delBtn.visible = true;
         }
      }
      
      private function __selectClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:Array = null;
         var _loc2_:Point = null;
         if(model.monsterDic.getList().length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("monster.monsterFormation.noMonsterSelect"));
            return;
         }
         if(!_selectMonsterView)
         {
            _loc3_ = exploreModel.selectViewList;
            _selectMonsterView = new MonsterExploreHeadSelectView();
            _selectMonsterView.show(_loc3_,selectMonster);
            _selectMonsterView.addEventListener("dispose",__disposeSelectView);
            _loc2_ = new Point(this.displayWidth / 2,0);
            _loc2_ = this.localToGlobal(_loc2_);
            _selectMonsterView.x = _loc2_.x + 25;
            _selectMonsterView.y = _loc2_.y + 60;
         }
      }
      
      private function __disposeSelectView(param1:Event) : void
      {
         _selectMonsterView.removeEventListener("dispose",__disposeSelectView);
         _selectMonsterView = null;
      }
      
      private function selectMonster(param1:MonsterInfo) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:MonsterExploreFormationInfo = new MonsterExploreFormationInfo();
         if(data)
         {
            exploreModel.formationDic.del(data.monsterId);
            _loc2_.index = data.index;
            _loc2_.monsterId = param1.monsterId;
            _loc2_.fightPos = data.fightPos;
            _loc2_.isCaptain = data.isCaptain;
         }
         else
         {
            _loc2_.index = index;
            _loc2_.monsterId = param1.monsterId;
            _loc2_.fightPos = randFightPos;
            _loc2_.isCaptain = false;
         }
         data = _loc2_;
         exploreModel.formationDic.add(_loc2_.monsterId,_loc2_);
         MsgMan.notifyObserver("EXPLORE_HEAD_CHANGE");
      }
      
      private function get randFightPos() : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = [[],[1,3],[4,6],[7,9],[10,12]];
         var _loc2_:Array = [];
         var _loc1_:Array = [];
         for each(var _loc6_:MonsterExploreFormationInfo in exploreModel.formationDic)
         {
            _loc3_ = Math.ceil(_loc6_.fightPos / 3);
            _loc1_.push(_loc3_);
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            if(_loc1_.indexOf(_loc4_) == -1)
            {
               _loc2_.push(_loc5_[_loc4_]);
            }
            _loc4_++;
         }
         _loc2_.splice(0,1);
         var _loc7_:int = int(Math.ceil(Math.random() * _loc2_.length)) - 1;
         return _loc2_[_loc7_][1];
      }
      
      private function __delClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         exploreModel.formationDic.del(data.monsterId);
         MsgMan.notifyObserver("EXPLORE_HEAD_CHANGE");
      }
      
      private function __setCaptainHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         for each(var _loc2_:MonsterExploreFormationInfo in exploreModel.formationDic)
         {
            if(_loc2_.monsterId == data.monsterId)
            {
               _loc2_.isCaptain = true;
            }
            else
            {
               _loc2_.isCaptain = false;
            }
         }
         MsgMan.notifyObserver("EXPLORE_HEAD_CHANGE");
      }
      
      public function get data() : MonsterExploreFormationInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterExploreFormationInfo) : void
      {
         _data = param1;
         if(data)
         {
            monsterInfo = param1.monsterInfo;
            _captainBit.visible = data.isCaptain;
            _setCaptainBtn.visible = !data.isCaptain;
            if(monsterInfo)
            {
               _headIcon.icon = IconFactory.getCommonIconPath(monsterInfo.tempInfo.Icon);
               _headIcon.tipData = monsterInfo;
            }
            else
            {
               _headIcon.icon = null;
               _headIcon.tipData = null;
            }
         }
         else
         {
            _setCaptainBtn.visible = false;
            _captainBit.visible = false;
            _headIcon.icon = null;
            _headIcon.tipData = null;
         }
      }
      
      private function checkHasCaptain() : Boolean
      {
         for each(var _loc1_:MonsterExploreFormationInfo in exploreModel.formationDic)
         {
            if(_loc1_.isCaptain)
            {
               return true;
            }
         }
         return false;
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
         removeEvent();
         ObjectUtils.disposeObject(_headCon);
         _headCon = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_addImage);
         _addImage = null;
         ObjectUtils.disposeObject(_delBtn);
         _delBtn = null;
         super.dispose();
      }
   }
}

