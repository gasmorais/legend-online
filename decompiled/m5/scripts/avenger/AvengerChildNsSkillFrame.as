package avenger
{
   import avenger.item.AvengerChildNsSkillItem;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.avenger.AvengerChildNsInfo;
   import mvc.module.avenger.AvengerModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.AvengerManager;
   import yishi.utils.MsgMan;
   
   public class AvengerChildNsSkillFrame extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _skillBox:VBox;
      
      private var skillList:Vector.<AvengerChildNsSkillItem>;
      
      private var nsInfo:AvengerChildNsInfo;
      
      public function AvengerChildNsSkillFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillFrame.back");
         _skillBox = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsSkillFrame.skillBox");
         addToContent(_back);
         addToContent(_skillBox);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("AVENGER_CHILDNS_UPDATE",this,__updateSkillHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("AVENGER_CHILDNS_UPDATE",this,__updateSkillHandler);
      }
      
      private function __updateSkillHandler(param1:String, param2:Object) : void
      {
         refreshSkillView();
      }
      
      private function refreshSkillView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:AvengerChildNsSkillItem = null;
         _skillBox.removeAllChild();
         skillList = new Vector.<AvengerChildNsSkillItem>();
         var _loc2_:Array = [];
         var _loc4_:Array = model.getNsSkillList(nsInfo.childTemp.SkillMasterType,31);
         _loc2_ = _loc2_.concat(_loc4_);
         _loc4_ = model.getNsSkillList(nsInfo.childTemp.SkillMasterType,32);
         _loc2_ = _loc2_.concat(_loc4_);
         _loc3_ = 0;
         while(_loc3_ < 2)
         {
            _loc1_ = new AvengerChildNsSkillItem(_loc3_ + 1);
            _loc1_.nsInfo = nsInfo;
            _loc1_.tempInfo = _loc2_[_loc3_];
            _skillBox.addChild(_loc1_);
            skillList.push(_loc1_);
            _loc3_++;
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
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         this.titleText = LanguageMgr.GetTranslation("ChildNSLearnSkillFrame.title.text");
         if(param1 && param1.frameData)
         {
            nsInfo = param1.frameData as AvengerChildNsInfo;
            refreshSkillView();
         }
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_skillBox);
         _skillBox = null;
         LogicUtils.disposeDisplayCollection(skillList);
         skillList = null;
         super.dispose();
      }
   }
}

