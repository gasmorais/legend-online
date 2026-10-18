package theseusdoublepvp.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpRankInfo;
   import theseuspvp.item.TheseusPvpHeadIcon;
   import yishi.datas.templates.TheseusMultiPvpTempInfo;
   import yishi.manager.TempleteManager;
   
   public class TheseusDoublepvpTopitem extends Sprite
   {
      
      public var _top1:Bitmap;
      
      public var _top2:Bitmap;
      
      public var _top3:Bitmap;
      
      public var _top1NickNameTxt:FilterFrameText;
      
      public var _top1ServerNameTxt:FilterFrameText;
      
      public var _top2NickNameTxt:FilterFrameText;
      
      public var _top2ServerNameTxt:FilterFrameText;
      
      public var _top3NickNameTxt:FilterFrameText;
      
      public var _top3ServerNameTxt:FilterFrameText;
      
      public var _top2Icon:ScaleFrameImage;
      
      public var _top1Icon:ScaleFrameImage;
      
      public var _top3Icon:ScaleFrameImage;
      
      private var _headIcon1:TheseusPvpHeadIcon;
      
      private var _headIcon2:TheseusPvpHeadIcon;
      
      private var _headIcon3:TheseusPvpHeadIcon;
      
      private var _topStep1:GradientText;
      
      private var _topStep2:GradientText;
      
      private var _topStep3:GradientText;
      
      public function TheseusDoublepvpTopitem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _top1 = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.top1");
         _top2 = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.top2");
         _top3 = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.top3");
         _top1NickNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.top1NickNameTxt");
         _top1ServerNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.top1ServerNameTxt");
         _top2NickNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.top2NickNameTxt");
         _top2ServerNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.top2ServerNameTxt");
         _top3NickNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.top3NickNameTxt");
         _top3ServerNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.top3ServerNameTxt");
         _top2Icon = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.top2Icon");
         _top1Icon = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.top1Icon");
         _top3Icon = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.top3Icon");
         _headIcon1 = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.topHeadIcon1");
         _headIcon2 = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.topHeadIcon2");
         _headIcon3 = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.topHeadIcon3");
         _topStep1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.topStepTxt1");
         _topStep2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.topStepTxt2");
         _topStep3 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.topStepTxt3");
         addChild(_top1);
         addChild(_top2);
         addChild(_top3);
         addChild(_top1NickNameTxt);
         addChild(_top1ServerNameTxt);
         addChild(_top2NickNameTxt);
         addChild(_top2ServerNameTxt);
         addChild(_top3NickNameTxt);
         addChild(_top3ServerNameTxt);
         addChild(_top2Icon);
         addChild(_top1Icon);
         addChild(_top3Icon);
         addChild(_headIcon2);
         addChild(_headIcon1);
         addChild(_headIcon3);
         addChild(_topStep2);
         addChild(_topStep1);
         addChild(_topStep3);
         _top2Icon.visible = false;
         _top1Icon.visible = false;
         _top3Icon.visible = false;
         _top2ServerNameTxt.text = LanguageMgr.GetTranslation("ui.theseuspvp.waitRank");
         _top1ServerNameTxt.text = LanguageMgr.GetTranslation("ui.theseuspvp.waitRank");
         _top3ServerNameTxt.text = LanguageMgr.GetTranslation("ui.theseuspvp.waitRank");
      }
      
      public function resize(param1:int, param2:int) : void
      {
         this.x = param1 - this.width - 30;
      }
      
      public function updataView(param1:Array) : void
      {
         var _loc2_:TheseusMultiPvpTempInfo = null;
         var _loc3_:TheseusDoublePvpRankInfo = param1[0];
         if(_loc3_)
         {
            _loc2_ = TempleteManager.instance.theseusMultiPvpTempCate.getTempById(_loc3_.pvpId);
            _top1Icon.setFrame(_loc2_.MainType);
            _top1NickNameTxt.text = _loc3_.nickName;
            _top1ServerNameTxt.text = _loc3_.serverName;
            _headIcon1.headIcon = _loc3_.job;
            _topStep1.text = "" + _loc3_.integral;
            _top1Icon.visible = true;
         }
         else
         {
            _top1Icon.visible = false;
            _top1ServerNameTxt.text = LanguageMgr.GetTranslation("ui.theseuspvp.waitRank");
         }
         var _loc4_:TheseusDoublePvpRankInfo = param1[1];
         if(_loc4_)
         {
            _loc2_ = TempleteManager.instance.theseusMultiPvpTempCate.getTempById(_loc4_.pvpId);
            _top2Icon.setFrame(_loc2_.MainType);
            _top2NickNameTxt.text = _loc4_.nickName;
            _top2ServerNameTxt.text = _loc4_.serverName;
            _headIcon2.headIcon = _loc4_.job;
            _topStep2.text = "" + _loc4_.integral;
            _top2Icon.visible = true;
         }
         else
         {
            _top2Icon.visible = false;
            _top2ServerNameTxt.text = LanguageMgr.GetTranslation("ui.theseuspvp.waitRank");
         }
         var _loc5_:TheseusDoublePvpRankInfo = param1[2];
         if(_loc5_)
         {
            _loc2_ = TempleteManager.instance.theseusMultiPvpTempCate.getTempById(_loc5_.pvpId);
            _top3Icon.setFrame(_loc2_.MainType);
            _top3NickNameTxt.text = _loc5_.nickName;
            _top3ServerNameTxt.text = _loc5_.serverName;
            _headIcon3.headIcon = _loc5_.job;
            _topStep3.text = "" + _loc5_.integral;
            _top3Icon.visible = true;
         }
         else
         {
            _top3Icon.visible = false;
            _top3ServerNameTxt.text = LanguageMgr.GetTranslation("ui.theseuspvp.waitRank");
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_top1);
         _top1 = null;
         ObjectUtils.disposeObject(_top2);
         _top2 = null;
         ObjectUtils.disposeObject(_top3);
         _top3 = null;
         ObjectUtils.disposeObject(_top1NickNameTxt);
         _top1NickNameTxt = null;
         ObjectUtils.disposeObject(_top1ServerNameTxt);
         _top1ServerNameTxt = null;
         ObjectUtils.disposeObject(_top2NickNameTxt);
         _top2NickNameTxt = null;
         ObjectUtils.disposeObject(_top2ServerNameTxt);
         _top2ServerNameTxt = null;
         ObjectUtils.disposeObject(_top3NickNameTxt);
         _top3NickNameTxt = null;
         ObjectUtils.disposeObject(_top3ServerNameTxt);
         _top3ServerNameTxt = null;
         ObjectUtils.disposeObject(_top2Icon);
         _top2Icon = null;
         ObjectUtils.disposeObject(_top1Icon);
         _top1Icon = null;
         ObjectUtils.disposeObject(_top3Icon);
         _top3Icon = null;
         ObjectUtils.disposeObject(_headIcon1);
         _headIcon1 = null;
         ObjectUtils.disposeObject(_headIcon2);
         _headIcon2 = null;
         ObjectUtils.disposeObject(_headIcon3);
         _headIcon3 = null;
         ObjectUtils.disposeObject(_topStep2);
         _topStep2 = null;
         ObjectUtils.disposeObject(_topStep1);
         _topStep1 = null;
         ObjectUtils.disposeObject(_topStep3);
         _topStep3 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

