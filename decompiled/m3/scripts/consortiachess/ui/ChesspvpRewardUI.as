package consortiachess.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class ChesspvpRewardUI extends Sprite
   {
      
      protected var _rdImg:Image;
      
      protected var _rdT2:FilterFrameText;
      
      protected var _rdT1:FilterFrameText;
      
      private var _type:int;
      
      private var _data:CommonDropTempInfo;
      
      public function ChesspvpRewardUI(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      protected function initView() : void
      {
         _rdImg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdImg");
         _rdT2 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdT2");
         _rdT1 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdT1");
         addChild(_rdImg);
         addChild(_rdT2);
         addChild(_rdT1);
      }
      
      public function set data(param1:CommonDropTempInfo) : void
      {
         var _loc2_:String = null;
         _data = param1;
         if(_data)
         {
            switch(_type - 1)
            {
               case 0:
                  _loc2_ = _data.para2;
                  _loc2_ = _loc2_.replace(",","-");
                  _rdT1.text = LanguageMgr.GetTranslation("chesspvp.reward.rankSort",_loc2_);
                  _rdT2.text = "" + _data.count;
                  break;
               case 1:
                  _rdT1.text = LanguageMgr.GetTranslation("chesspvp.reward.day.r" + _data.para2);
                  _rdT2.text = "" + _data.count;
            }
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_rdImg);
         _rdImg = null;
         ObjectUtils.disposeObject(_rdT2);
         _rdT2 = null;
         ObjectUtils.disposeObject(_rdT1);
         _rdT1 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

