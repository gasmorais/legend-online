package ancientartifact.view
{
   import ancientartifact.view.item.AncientStrengthenItem;
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class AncientStrengthenView extends Component
   {
      
      private var _templateId:int;
      
      private var _template:ArtifactTemplateInfo;
      
      private var _data:AncientArtifactInfo;
      
      private var _bg:Bitmap;
      
      private var _strengthNumBmp:Bitmap;
      
      private var _strengthItemNote:Bitmap;
      
      private var _hasShenZhuShi:FilterFrameText;
      
      private var _trainCountText:FilterFrameText;
      
      private var _trainCountBg:Bitmap;
      
      private var _useStoneBtn:IconButton;
      
      private var _strengthIcon:Image;
      
      private var _filter:UIFilter;
      
      private var _strengthenItem1:AncientStrengthenItem;
      
      private var _strengthenItem2:AncientStrengthenItem;
      
      private var _strengthenItem3:AncientStrengthenItem;
      
      private var _strengthenItem4:AncientStrengthenItem;
      
      private var _strengthenItem5:AncientStrengthenItem;
      
      private var _strengthenItem6:AncientStrengthenItem;
      
      private var _strengthenItem7:AncientStrengthenItem;
      
      public function AncientStrengthenView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.strengthBg");
         _strengthNumBmp = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.strengthNumBmp");
         _strengthItemNote = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.strengthItemNote");
         _hasShenZhuShi = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.hasShenZhuShi");
         _trainCountText = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.useShenZhuShi");
         _trainCountBg = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.strengthNumBg");
         _useStoneBtn = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.useStoneBtn");
         _strengthIcon = ComponentFactory.Instance.creatComponentByStylename("AncientStrengthenView.strengthIcon");
         _filter = new UIFilter();
         _strengthenItem1 = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientStrengthenItem",[1]);
         _strengthenItem1.x = 376;
         _strengthenItem1.y = 27;
         _strengthenItem2 = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientStrengthenItem",[2]);
         _strengthenItem2.x = 376;
         _strengthenItem2.y = 73;
         _strengthenItem3 = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientStrengthenItem",[3]);
         _strengthenItem3.x = 376;
         _strengthenItem3.y = 117;
         _strengthenItem4 = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientStrengthenItem",[4]);
         _strengthenItem4.x = 376;
         _strengthenItem4.y = 160;
         _strengthenItem5 = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientStrengthenItem",[5]);
         _strengthenItem5.x = 376;
         _strengthenItem5.y = 204;
         _strengthenItem6 = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientStrengthenItem",[6]);
         _strengthenItem6.x = 376;
         _strengthenItem6.y = 247;
         _strengthenItem7 = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientStrengthenItem",[7]);
         _strengthenItem7.x = 376;
         _strengthenItem7.y = 289;
         addChild(_bg);
         addChild(_strengthNumBmp);
         addChild(_strengthItemNote);
         addChild(_hasShenZhuShi);
         addChild(_trainCountBg);
         addChild(_trainCountText);
         addChild(_useStoneBtn);
         addChild(_strengthIcon);
         addChild(_strengthenItem1);
         addChild(_strengthenItem2);
         addChild(_strengthenItem3);
         addChild(_strengthenItem4);
         addChild(_strengthenItem5);
         addChild(_strengthenItem6);
         addChild(_strengthenItem7);
         _trainCountText.text = "1";
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(212018);
         if(_loc1_)
         {
            _strengthIcon.tipData = _loc1_.Description;
         }
      }
      
      private function initEvent() : void
      {
         _useStoneBtn.addEventListener("click",__useStoneHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__onUpdateNumberHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__onUpdateNumberHandler);
         _trainCountText.addEventListener("change",__textChangHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_ITEM_CLICK",__itemClickHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_INFO_UPDATE",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         if(_useStoneBtn)
         {
            _useStoneBtn.removeEventListener("click",__useStoneHandler);
         }
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__onUpdateNumberHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__onUpdateNumberHandler);
         if(_trainCountText)
         {
            _trainCountText.removeEventListener("change",__textChangHandler);
         }
         NotificationManager.instance.removeEventListener("ARTIFACT_ITEM_CLICK",__itemClickHandler);
         NotificationManager.instance.removeEventListener("ARTIFACT_INFO_UPDATE",__updateViewHandler);
      }
      
      private function __useStoneHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.STRENGTHEN,_templateId,int(_trainCountText.text));
      }
      
      private function __onUpdateNumberHandler(param1:BagEvent = null) : void
      {
         _hasShenZhuShi.text = ownStone.toString();
         _trainCountText.text = "1";
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_trainCountText.text);
         if(_loc2_ <= 0)
         {
            _trainCountText.text = "1";
         }
         if(_loc2_ >= ownStone)
         {
            _trainCountText.text = ownStone.toString();
         }
      }
      
      private function __itemClickHandler(param1:NotificationEvent) : void
      {
         __updateViewHandler(null);
      }
      
      private function __updateViewHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:int = 0;
         _templateId = AncientArtifactManager.instance.selectTempId;
         _template = TempleteManager.instance.artifactTemplateCate.getTemplateById(_templateId);
         _data = model.getArtifactInfoById(_templateId);
         _loc2_ = 1;
         while(_loc2_ <= 7)
         {
            this["_strengthenItem" + _loc2_].setData(_template,_data,param1);
            _loc2_++;
         }
         _hasShenZhuShi.text = ownStone.toString();
         if(_data)
         {
            _filter.setNormalFilter(this);
         }
         else
         {
            _filter.setGrayFilter(this);
         }
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      private function get ownStone() : int
      {
         return GoodsManager.instance.getGoodsNumByTempId(212018);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_strengthNumBmp);
         _strengthNumBmp = null;
         ObjectUtils.disposeObject(_strengthItemNote);
         _strengthItemNote = null;
         ObjectUtils.disposeObject(_hasShenZhuShi);
         _hasShenZhuShi = null;
         ObjectUtils.disposeObject(_trainCountText);
         _trainCountText = null;
         ObjectUtils.disposeObject(_trainCountBg);
         _trainCountBg = null;
         ObjectUtils.disposeObject(_useStoneBtn);
         _useStoneBtn = null;
         ObjectUtils.disposeObject(_strengthIcon);
         _strengthIcon = null;
         ObjectUtils.disposeObject(_strengthenItem1);
         _strengthenItem1 = null;
         ObjectUtils.disposeObject(_strengthenItem2);
         _strengthenItem2 = null;
         ObjectUtils.disposeObject(_strengthenItem3);
         _strengthenItem3 = null;
         ObjectUtils.disposeObject(_strengthenItem4);
         _strengthenItem4 = null;
         ObjectUtils.disposeObject(_strengthenItem5);
         _strengthenItem5 = null;
         ObjectUtils.disposeObject(_strengthenItem6);
         _strengthenItem6 = null;
         ObjectUtils.disposeObject(_strengthenItem7);
         _strengthenItem7 = null;
         _filter = null;
         _template = null;
         _data = null;
         super.dispose();
      }
   }
}

