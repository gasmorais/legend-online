package map.internals.battle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.PlayerManager;
   import yishi.view.community.BaseItemView;
   
   public class ChestItemView extends Sprite
   {
      
      private var _goods:BaseItemView;
      
      private var _nickName:String;
      
      private var _goodsInfo:GoodsInfo;
      
      private var _effectMovie:MovieClip;
      
      private var _goodsTxt:FilterFrameText;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _otherNameTxt:FilterFrameText;
      
      public var timeout:Boolean = false;
      
      public var isPay:Boolean;
      
      public var index:int;
      
      public var isChested:Boolean = false;
      
      private var _tempData:GoodsInfo;
      
      public function ChestItemView()
      {
         super();
         init();
         initEvent();
      }
      
      public function playReverseBack() : void
      {
         _effectMovie.gotoAndPlay("f_1");
         _effectMovie["content"].addChild(_goodsTxt);
         _effectMovie["content"].addChild(_nickNameTxt);
         _effectMovie["content"].addChild(_goods);
      }
      
      public function playReversePre() : void
      {
         _effectMovie.gotoAndPlay("f_2");
         _effectMovie["content"].addChild(_goodsTxt);
         _effectMovie["content"].addChild(_nickNameTxt);
         _effectMovie["content"].addChild(_goods);
      }
      
      public function playDefaut() : void
      {
         _effectMovie.gotoAndStop("f_2");
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         var _loc2_:GoodsTemplateInfo = null;
         _tempData = param1;
         if(_tempData)
         {
            _goods.showProfile = true;
            _goods.data = _tempData;
            if(_tempData.templateId == -100 || _tempData.templateId == -200 || _tempData.templateId == -300)
            {
               ShowTipManager.Instance.removeTip(_goods);
            }
            _loc2_ = _tempData.templateInfo;
            if(_loc2_)
            {
               _goodsTxt.text = _loc2_.TemplateName;
               _goodsTxt.setFrame(_loc2_.Profile);
            }
         }
      }
      
      private function init() : void
      {
         mouseEnabled = false;
         _effectMovie = ComponentFactory.Instance.creatCustomObject("chest.ItemEffect");
         addChild(_effectMovie);
         _effectMovie.gotoAndStop(1);
         _goodsTxt = ComponentFactory.Instance.creatComponentByStylename("chest.GoodsNameTxt");
         _effectMovie["content"].addChild(_goodsTxt);
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("chest.NickNameTxt");
         _effectMovie["content"].addChild(_nickNameTxt);
         _otherNameTxt = ComponentFactory.Instance.creatComponentByStylename("chest.OtherNameTxt");
         _goods = ComponentFactory.Instance.creatCustomObject("core.chest.GoodsItem");
         _effectMovie["content"].addChild(_goods);
      }
      
      private function initEvent() : void
      {
         _effectMovie.addEventListener("complete",__completeHandler);
      }
      
      private function removeEvent() : void
      {
         _effectMovie && _effectMovie.removeEventListener("complete",__completeHandler);
      }
      
      private function __completeHandler(param1:Event) : void
      {
         _effectMovie["content"].addChild(_goodsTxt);
         _effectMovie["content"].addChild(_nickNameTxt);
         _effectMovie["content"].addChild(_goods);
      }
      
      public function updateData(param1:int, param2:String, param3:GoodsInfo) : void
      {
         _goodsInfo = param3;
         _nickName = param2;
         initData();
         playReversePre();
         isChested = true;
      }
      
      private function initData() : void
      {
         this.buttonMode = false;
         _goods.data = _goodsInfo;
         addChild(_goods);
         if(_goodsInfo.templateId == -100 || _goodsInfo.templateId == -200 || _goodsInfo.templateId == -300)
         {
            ShowTipManager.Instance.removeTip(_goods);
         }
         var _loc1_:GoodsTemplateInfo = _goodsInfo.templateInfo;
         _goodsTxt.text = _loc1_.TemplateName;
         _goodsTxt.setFrame(_loc1_.Profile);
         if(_nickName == PlayerManager.instance.currentPlayerModel.playerInfo.nickName)
         {
            addChild(_nickNameTxt);
            _nickNameTxt.text = _nickName;
            if(_otherNameTxt && _otherNameTxt.parent)
            {
               _otherNameTxt.parent.removeChild(_otherNameTxt);
            }
         }
         else
         {
            addChild(_otherNameTxt);
            _otherNameTxt.text = _nickName;
            if(_nickNameTxt && _nickNameTxt.parent)
            {
               _nickNameTxt.parent.removeChild(_nickNameTxt);
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_effectMovie);
         _effectMovie = null;
         if(_goodsTxt)
         {
            _goodsTxt.dispose();
         }
         _goodsTxt = null;
         if(_otherNameTxt)
         {
            _otherNameTxt.dispose();
         }
         _otherNameTxt = null;
         if(_nickNameTxt)
         {
            _nickNameTxt.dispose();
         }
         _nickNameTxt = null;
         if(_goods)
         {
            _goods.dispose();
         }
         _goods = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _goodsInfo = null;
      }
   }
}

