package pethallows
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import yishi.manager.PetHallowsManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   
   public class PetHallowsFrame extends Frame implements IManualSize
   {
      
      private var back:Bitmap;
      
      private var border:ScaleBitmapImage;
      
      private var contracBtn:SelectedIconButton;
      
      private var hallowsBtn:SelectedIconButton;
      
      private var inscriptionBtn:SelectedIconButton;
      
      private var leftView:PetHallowsLeftView;
      
      private var addAttImage:Image;
      
      private var petContracView:PetContracView;
      
      private var petHallowsView:PetHallowsView;
      
      private var inscriptionView:PetInscriptionView;
      
      private var btnGroup:SelectedButtonGroup;
      
      public function PetHallowsFrame()
      {
         super();
         initView();
         addEvent();
         btnGroup.selectIndex = 0;
         leftView.setFirstSelect();
         refreshView();
         PetHallowsManager.instance.sendPetHallowsRequest(4);
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,910,605);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         btnGroup = new SelectedButtonGroup();
         back = ComponentFactory.Instance.creatBitmap("asset.PetHallowsFrame.back");
         border = ComponentFactory.Instance.creatComponentByStylename("PetHallowsFrame.border");
         addAttImage = ComponentFactory.Instance.creatComponentByStylename("PetHallowsFrame.addAttImage");
         contracBtn = ComponentFactory.Instance.creatComponentByStylename("PetHallowsFrame.contracBtn");
         hallowsBtn = ComponentFactory.Instance.creatComponentByStylename("PetHallowsFrame.hallowsBtn");
         inscriptionBtn = ComponentFactory.Instance.creatComponentByStylename("PetHallowsFrame.inscriptionBtn");
         leftView = ComponentFactory.Instance.creatCustomObject("PetHallowsFrame.leftView");
         addToContent(back);
         addToContent(border);
         addToContent(addAttImage);
         addToContent(contracBtn);
         addToContent(hallowsBtn);
         addToContent(inscriptionBtn);
         addToContent(leftView);
         btnGroup.addSelectItem(contracBtn);
         btnGroup.addSelectItem(hallowsBtn);
         btnGroup.addSelectItem(inscriptionBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         btnGroup.addEventListener("change",__selectedChangHandler);
         MsgMan.addObserver("PET_HALLOWS_HEAD_SELECT",this,__hallowsHeadSelectHandler);
         MsgMan.addObserver("PET_HALLOWS_MSG_UPDATE",this,__hallowsHeadSelectHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         btnGroup.removeEventListener("change",__selectedChangHandler);
         MsgMan.removeObserver("PET_HALLOWS_HEAD_SELECT",this,__hallowsHeadSelectHandler);
         MsgMan.removeObserver("PET_HALLOWS_MSG_UPDATE",this,__hallowsHeadSelectHandler);
      }
      
      private function __hallowsHeadSelectHandler(param1:String, param2:Object) : void
      {
         refreshView();
         leftView.refreshView();
         if(petHallowsView && petHallowsView.parent)
         {
            petHallowsView.refreshView();
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:Object = {};
         if(model.selectedHallowsTemp)
         {
            if(btnGroup.selectIndex == 0)
            {
               _loc1_.type = 1;
               _loc1_.dic = model.getContracAddDicByHallowsType(model.selectedHallowsTemp.HallowType);
               addAttImage.tipData = _loc1_;
            }
            else if(btnGroup.selectIndex == 2)
            {
               _loc1_.type = 4;
               _loc1_.dic = model.getInscriptionAddDicByHallowsType(model.selectedHallowsTemp.HallowType);
               addAttImage.tipData = _loc1_;
            }
         }
      }
      
      private function __selectedChangHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(btnGroup.selectIndex == 0)
         {
            addAttImage.visible = true;
            ObjectUtils.disposeObject(petHallowsView);
            petHallowsView = null;
            ObjectUtils.disposeObject(inscriptionView);
            inscriptionView = null;
            if(!petContracView)
            {
               petContracView = ComponentFactory.Instance.creatCustomObject("PetHallowsFrame.petContracView");
            }
            if(!petContracView.parent)
            {
               addToContent(petContracView);
            }
         }
         else if(btnGroup.selectIndex == 1)
         {
            addAttImage.visible = false;
            ObjectUtils.disposeObject(petContracView);
            petContracView = null;
            ObjectUtils.disposeObject(inscriptionView);
            inscriptionView = null;
            if(!petHallowsView)
            {
               petHallowsView = ComponentFactory.Instance.creatCustomObject("PetHallowsFrame.petHallowsView");
            }
            if(!petHallowsView.parent)
            {
               addToContent(petHallowsView);
            }
            petHallowsView.mouseEnabled = false;
         }
         else if(btnGroup.selectIndex == 2)
         {
            addAttImage.visible = true;
            ObjectUtils.disposeObject(petHallowsView);
            petHallowsView = null;
            ObjectUtils.disposeObject(petContracView);
            petContracView = null;
            if(!inscriptionView)
            {
               inscriptionView = ComponentFactory.Instance.creatCustomObject("PetHallowsFrame.inscriptionView");
            }
            if(!inscriptionView.parent)
            {
               addToContent(inscriptionView);
            }
            inscriptionView.mouseEnabled = false;
         }
         refreshView();
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
      
      public function show() : void
      {
         this.titleText = LanguageMgr.GetTranslation("PetHallowsFrame.titleText.text");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function get model() : PetHallowsModel
      {
         return PetHallowsManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         model.selectedHallowsTemp = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(border);
         border = null;
         ObjectUtils.disposeObject(contracBtn);
         contracBtn = null;
         ObjectUtils.disposeObject(hallowsBtn);
         hallowsBtn = null;
         ObjectUtils.disposeObject(inscriptionBtn);
         inscriptionBtn = null;
         ObjectUtils.disposeObject(leftView);
         leftView = null;
         ObjectUtils.disposeObject(addAttImage);
         addAttImage = null;
         ObjectUtils.disposeObject(petHallowsView);
         petHallowsView = null;
         ObjectUtils.disposeObject(petContracView);
         petContracView = null;
         ObjectUtils.disposeObject(inscriptionView);
         inscriptionView = null;
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
         super.dispose();
      }
   }
}

