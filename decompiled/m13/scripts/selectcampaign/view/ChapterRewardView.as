package selectcampaign.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.view.community.BaseItemView;
   
   public class ChapterRewardView extends Sprite implements Disposeable
   {
      
      public var chapterRewardBox:HBox;
      
      public var chapterSSSBox:HBox;
      
      public var chapterTipAsset:FilterFrameText;
      
      private var _bg:DisplayObject;
      
      private var _upBack:ScaleBitmapImage;
      
      private var _downBack:ScaleBitmapImage;
      
      private var _sssBack:Bitmap;
      
      private var _lastBack:Bitmap;
      
      private var _closeBtn:BaseButton;
      
      public function ChapterRewardView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.chapterRewardView.bg");
         chapterRewardBox = ComponentFactory.Instance.creatComponentByStylename("selecteCP.DistrictGoodsBox");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("chapterRewardView.CloseBtn");
         _upBack = ComponentFactory.Instance.creatComponentByStylename("selecteCP.upBack");
         _downBack = ComponentFactory.Instance.creatComponentByStylename("selecteCP.downBack");
         _sssBack = ComponentFactory.Instance.creatBitmap("asset.selectCP.SSSBack");
         _lastBack = ComponentFactory.Instance.creatBitmap("asset.selectCP.lastBack");
         chapterSSSBox = ComponentFactory.Instance.creatComponentByStylename("selecteCP.SSSGoodsBox");
         chapterTipAsset = ComponentFactory.Instance.creatComponentByStylename("selecteCP.chapterTipAsset");
         addChild(_bg);
         addChild(_upBack);
         addChild(_downBack);
         addChild(_sssBack);
         addChild(_lastBack);
         addChild(chapterTipAsset);
         addChild(chapterRewardBox);
         addChild(chapterSSSBox);
         addChild(_closeBtn);
         chapterTipAsset.text = LanguageMgr.GetTranslation("selecteCP.chapterTipAsset");
         chapterTipAsset.visible = false;
      }
      
      private function initEvents() : void
      {
         _closeBtn.addEventListener("click",__onCloseBtnClick);
      }
      
      private function __onCloseBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         this.visible = false;
      }
      
      private function removeEvent() : void
      {
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__onCloseBtnClick);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         for each(var _loc1_:BaseItemView in chapterRewardBox)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         if(chapterRewardBox)
         {
            chapterRewardBox.removeAllChild();
         }
         ObjectUtils.disposeObject(chapterRewardBox);
         chapterRewardBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

