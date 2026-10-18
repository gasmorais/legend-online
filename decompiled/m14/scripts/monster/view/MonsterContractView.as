package monster.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import monster.item.MonsterContractItem;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.manager.MonsterManager;
   import yishi.utils.MsgMan;
   
   public class MonsterContractView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _contractImage:Image;
      
      private var _hbox:HBox;
      
      private var contractList:Vector.<MonsterContractItem>;
      
      private var contractLen:int = 3;
      
      public function MonsterContractView()
      {
         super();
         initView();
         initListView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.MonsterContractView.back");
         _contractImage = ComponentFactory.Instance.creatComponentByStylename("MonsterContractView.contractImage");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("MonsterContractView.hbox");
         addChild(_back);
         addChild(_contractImage);
         addChild(_hbox);
         _contractImage.tipData = LanguageMgr.GetTranslation("MonsterContractView.contractImage.tipData");
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MonsterContractItem = null;
         contractList = new Vector.<MonsterContractItem>();
         _loc2_ = 0;
         while(_loc2_ < contractLen)
         {
            _loc1_ = new MonsterContractItem(_loc2_);
            _hbox.addChild(_loc1_);
            contractList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("CONTRACT_INFO_CHANGE",this,__selectMonsterHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("CONTRACT_INFO_CHANGE",this,__selectMonsterHandler);
      }
      
      private function __selectMonsterHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:MonsterContractItem = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < contractLen)
         {
            _loc1_ = contractList[_loc3_];
            _loc2_ = int(model.contractIds[_loc3_]);
            if(model.monsterDic[_loc2_])
            {
               _loc1_.data = model.monsterDic[_loc2_];
            }
            else
            {
               _loc1_.data = null;
            }
            _loc3_++;
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_contractImage);
         _contractImage = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         LogicUtils.disposeDisplayCollection(contractList);
         contractList = null;
         super.dispose();
      }
   }
}

