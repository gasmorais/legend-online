package archaeology
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.archeology.ArchaeologyItemInfo;
   import mvc.module.archeology.ArchaeologyModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ArchaeologyItemTemplate;
   import yishi.manager.ArchaeologyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   
   public class ArchaeologyMakeRightView extends Component
   {
      
      private var stargazingBtn:BaseButton;
      
      private var itemNameText:FilterFrameText;
      
      private var descText:FilterFrameText;
      
      private var rewardItem:BaseItemView;
      
      private var descPic:Bitmap;
      
      private var historyPic:Bitmap;
      
      private var processBar:MovieClip;
      
      private var processText:FilterFrameText;
      
      private var rechargeBtn:BaseButton;
      
      private var _data:ArchaeologyItemInfo;
      
      private var _itemTemp:ArchaeologyItemTemplate;
      
      private var curLevel:int;
      
      public function ArchaeologyMakeRightView()
      {
         super();
         initView();
         addEvent();
         __selectItemChange("",null);
      }
      
      private function initView() : void
      {
         stargazingBtn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeRightView.stargazingBtn");
         itemNameText = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeRightView.itemNameText");
         descText = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeRightView.descText");
         rewardItem = ComponentFactory.Instance.creatCustomObject("ArchaeologyMakeRightView.rewardItem");
         processBar = ComponentFactory.Instance.creatCustomObject("ArchaeologyMakeRightView.processBar");
         processText = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeRightView.processText");
         rechargeBtn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyMakeRightView.rechargeBtn");
         historyPic = ComponentFactory.Instance.creatBitmap("asset.ArchaeologyMakeRightView.historyPic");
         addChild(stargazingBtn);
         addChild(itemNameText);
         addChild(descText);
         addChild(rewardItem);
         addChild(processBar);
         addChild(processText);
         addChild(rechargeBtn);
         processBar.movie.gotoAndStop(1);
         rechargeBtn.enable = false;
         curLevel = model.getGradeByExp(model.exp);
         stargazingBtn.autoHideTip = false;
         stargazingBtn.visible = VersionSwitch.STAR_GAZING;
         stargazingBtn.enable = curLevel >= 3;
         stargazingBtn.tipData = curLevel >= 3 ? null : LanguageMgr.GetTranslation("ArchaeologyMakeRightView.stargazingBtn.tipdata");
      }
      
      private function addEvent() : void
      {
         rechargeBtn.addEventListener("click",__rechargeClickHandler);
         stargazingBtn.addEventListener("click",__stargazingClickHandler);
         MsgMan.addObserver("ARCHAEOLOGY_LEFTITEM_SELECT",this,__selectItemChange);
      }
      
      private function removeEvent() : void
      {
         if(rechargeBtn)
         {
            rechargeBtn.removeEventListener("click",__rechargeClickHandler);
         }
         if(stargazingBtn)
         {
            stargazingBtn.removeEventListener("click",__stargazingClickHandler);
         }
         MsgMan.removeObserver("ARCHAEOLOGY_LEFTITEM_SELECT",this,__selectItemChange);
      }
      
      private function __stargazingClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("stargazing");
      }
      
      private function __rechargeClickHandler(param1:MouseEvent) : void
      {
         ArchaeologyManager.instance.sendArchaeologyRequest(3,_data.tempId);
      }
      
      private function __selectItemChange(param1:String, param2:Object) : void
      {
         data = param2 as ArchaeologyItemInfo;
      }
      
      public function set data(param1:ArchaeologyItemInfo) : void
      {
         _data = param1;
         cleanData();
         if(!_data || _data.cellType == 1)
         {
            return;
         }
         _itemTemp = TempleteManager.instance.archaeologyItemTemplateCate.getTemplateByID(_data.tempId);
         if(!_itemTemp)
         {
            return;
         }
         loadDescPic();
         rewardItem.visible = true;
         itemNameText.text = _itemTemp.Name;
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _itemTemp.RewardId;
         _loc2_.count = _itemTemp.RewardCount;
         rewardItem.data = _loc2_;
         processText.text = _data.chipCount + "/" + _itemTemp.NeedChip;
         if(_data.chipCount >= _itemTemp.NeedChip)
         {
            rechargeBtn.enable = true;
            processBar.movie.gotoAndStop(100);
         }
         else
         {
            rechargeBtn.enable = false;
            processBar.movie.gotoAndStop(int(_data.chipCount * 100 / _itemTemp.NeedChip));
         }
      }
      
      private function loadDescPic() : void
      {
         if(!_itemTemp)
         {
            return;
         }
         var _loc1_:String = PathManager.getArchaeologyDescPicPath(_itemTemp.Pic);
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onloadDescPicComplete);
         LoaderManagerII.instance.load(_loc1_,2,8,onloadDescPicComplete);
      }
      
      public function onloadDescPicComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(param2)
         {
            descPic = param2 as Bitmap;
            addChild(descPic);
            addChild(historyPic);
         }
         resetDescText();
      }
      
      private function resetDescText() : void
      {
         if(!_itemTemp)
         {
            return;
         }
         if(!descPic)
         {
            return;
         }
         historyPic.visible = true;
         descText.text = _itemTemp.Detail;
         if(_itemTemp.PicLayout == 1)
         {
            descPic.x = 84;
            descPic.y = 62;
            historyPic.x = 170;
            historyPic.y = 170;
            descText.width = 380;
            descText.x = 105;
            descText.y = 200;
         }
         else
         {
            descPic.x = 52;
            descPic.y = 57;
            historyPic.x = 285;
            historyPic.y = 100;
            descText.width = 185;
            descText.x = 325;
            descText.y = 140;
         }
      }
      
      private function cleanData() : void
      {
         itemNameText.text = "";
         descText.text = "";
         rewardItem.data = null;
         processText.text = "";
         historyPic.visible = false;
         rewardItem.visible = false;
         processBar.movie.gotoAndStop(1);
         rechargeBtn.enable = false;
         ObjectUtils.disposeObject(descPic);
         descPic = null;
      }
      
      public function get model() : ArchaeologyModel
      {
         return ArchaeologyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onloadDescPicComplete);
         if(itemNameText)
         {
            ObjectUtils.disposeObject(itemNameText);
         }
         itemNameText = null;
         if(historyPic)
         {
            ObjectUtils.disposeObject(historyPic);
         }
         historyPic = null;
         if(descText)
         {
            ObjectUtils.disposeObject(descText);
         }
         descText = null;
         if(rewardItem)
         {
            ObjectUtils.disposeObject(rewardItem);
         }
         rewardItem = null;
         if(processBar)
         {
            ObjectUtils.disposeViolentMc(processBar);
         }
         processBar = null;
         if(processText)
         {
            ObjectUtils.disposeObject(processText);
         }
         processText = null;
         if(rechargeBtn)
         {
            ObjectUtils.disposeObject(rechargeBtn);
         }
         rechargeBtn = null;
         if(descPic)
         {
            ObjectUtils.disposeObject(descPic);
         }
         descPic = null;
         if(stargazingBtn)
         {
            ObjectUtils.disposeObject(stargazingBtn);
         }
         stargazingBtn = null;
         _data = null;
         _itemTemp = null;
         super.dispose();
      }
   }
}

