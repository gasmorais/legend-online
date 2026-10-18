package sqmemory.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.SqMemoryManger;
   import sqmemory.item.SqmemoryItem;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   
   public class SqmemoryPage3 extends SqmemoryBasePage
   {
      
      private var _leftVbox:VBox;
      
      private var _rightVbox:VBox;
      
      private var _rightT1:FilterFrameText;
      
      private var _rightT2:GradientText;
      
      private var _rightT3:FilterFrameText;
      
      public function SqmemoryPage3()
      {
         super();
         initView();
         initData();
      }
      
      private function initView() : void
      {
         _leftVbox = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.page2.vbox");
         _rightVbox = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.page1.vbox");
         _rightT1 = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.page3R1");
         _rightT2 = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.page3R2Gt");
         _rightT3 = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.page3R3");
         addChild(_leftVbox);
         addChild(_rightVbox);
         addChild(_rightT1);
         addChild(_rightT2);
         addChild(_rightT3);
      }
      
      private function initData() : void
      {
         var _loc8_:SqmemoryItem = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc12_:String = null;
         var _loc9_:* = null;
         var _loc7_:String = null;
         var _loc1_:int = 0;
         var _loc13_:String = null;
         var _loc6_:String = null;
         var _loc11_:String = null;
         var _loc10_:String = SqMemoryManger.Instance.userDataInfo.growthInfo;
         var _loc3_:Array = _loc10_.split("|");
         _leftVbox.beginChanges();
         _loc8_ = new SqmemoryItem(2);
         _loc7_ = LanguageMgr.GetTranslation("sqMemory.note.grow1");
         _loc8_.updateView(_loc7_);
         _leftVbox.addChild(_loc8_);
         _loc12_ = _loc3_[0];
         _loc8_ = createNote(_loc12_,["sqMemory.note.grow1_Y_1","sqMemory.note.grow1_N_1"],[3,3],true);
         _leftVbox.addChild(_loc8_);
         _loc12_ = _loc3_[1];
         _loc8_ = createNote(_loc12_,["sqMemory.note.grow1_Y_2","sqMemory.note.grow1_N_2"],[3,3],true);
         _leftVbox.addChild(_loc8_);
         _leftVbox.commitChanges();
         _rightT1.text = LanguageMgr.GetTranslation("sqMemory.note.grow2");
         var _loc5_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.vocationLevel);
         if(_loc5_ <= 0)
         {
            _loc1_ = thane.templateInfo.Job + 1;
            _loc13_ = LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name0" + _loc1_);
            _loc6_ = LanguageMgr.GetTranslation("fish.FishFrame.levelText",thane.grades);
            _rightT2.text = LanguageMgr.GetTranslation("sqMemory.note.grow2_1",thane.grades + _loc13_);
         }
         else
         {
            _loc11_ = PlayerManager.instance.getVocationName(thane.templateInfo.Job,PlayerManager.instance.currentPlayerModel.playerInfo.vocationStep,_loc5_);
            _rightT2.text = LanguageMgr.GetTranslation("sqMemory.note.grow2_1",_loc11_);
         }
         _rightT3.text = LanguageMgr.GetTranslation("sqMemory.note.grow2_2");
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_rightT1);
         _rightT1 = null;
         ObjectUtils.disposeObject(_rightT2);
         _rightT2 = null;
         ObjectUtils.disposeObject(_rightT3);
         _rightT3 = null;
         ObjectUtils.disposeAllChildren(_leftVbox);
         ObjectUtils.disposeObject(_leftVbox);
         _leftVbox = null;
         ObjectUtils.disposeAllChildren(_rightVbox);
         ObjectUtils.disposeObject(_rightVbox);
         _rightVbox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

