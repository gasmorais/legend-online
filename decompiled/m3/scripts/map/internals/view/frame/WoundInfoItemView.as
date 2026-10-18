package map.internals.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.worldboss.WoundInfo;
   
   public class WoundInfoItemView extends Sprite implements Disposeable
   {
      
      private var _indexTxt:FilterFrameText;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _woundTxt:FilterFrameText;
      
      private var _job:ScaleFrameImage;
      
      private var _woundInfo:WoundInfo;
      
      private var _isSelf:Boolean;
      
      public function WoundInfoItemView()
      {
         super();
         init();
      }
      
      public function get woundInfo() : WoundInfo
      {
         return _woundInfo;
      }
      
      public function set woundInfo(param1:WoundInfo) : void
      {
         _woundInfo = param1;
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc1_:int = 0;
         if(_woundInfo.wound <= 0)
         {
            _nickNameTxt.x = 0;
            _nickNameTxt.width = 200;
            if(_woundInfo.index == -1)
            {
               _nickNameTxt.text = LanguageMgr.GetTranslation("worldboss.view.WoundInfoItemView.nickName");
            }
            else
            {
               _nickNameTxt.text = "";
            }
            _indexTxt.text = "";
            _woundTxt.text = "";
            if(_job && _job.parent)
            {
               _job.parent.removeChild(_job);
            }
         }
         else
         {
            if(_woundInfo.index == -1)
            {
               _nickNameTxt.text = LanguageMgr.GetTranslation("worldboss.view.WoundInfoItemView.nickName01");
               _nickNameTxt.x = 0;
               _nickNameTxt.width = 200;
            }
            else
            {
               _nickNameTxt.x = 40;
               _nickNameTxt.width = 80;
               _indexTxt.text = _woundInfo.index + 1 + ".";
               _nickNameTxt.text = _woundInfo.nickName;
               _loc1_ = _woundInfo.job % 3;
               addChild(_job);
               switch(_loc1_)
               {
                  case 0:
                     _job.setFrame(3);
                     break;
                  case 1:
                     _job.setFrame(1);
                     break;
                  case 2:
                     _job.setFrame(2);
               }
            }
            _woundTxt.text = _woundInfo.wound + "";
         }
      }
      
      public function set isSelf(param1:Boolean) : void
      {
         _isSelf = param1;
         if(param1)
         {
            _nickNameTxt.text = LanguageMgr.GetTranslation("worldboss.view.WoundInfoItemView.nickName01");
         }
      }
      
      public function setFrame(param1:int) : void
      {
         _nickNameTxt.setFrame(param1);
         _woundTxt.setFrame(param1);
      }
      
      private function init() : void
      {
         _job = ComponentFactory.Instance.creatComponentByStylename("core.SmallHeroVocation");
         _indexTxt = ComponentFactory.Instance.creatComponentByStylename("worldboss.woundinfo.IndexTxt");
         addChild(_indexTxt);
         _indexTxt.text = "";
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("worldboss.woundinfo.NickNameTxt");
         addChild(_nickNameTxt);
         _nickNameTxt.text = "";
         _woundTxt = ComponentFactory.Instance.creatComponentByStylename("worldboss.woundinfo.WoundInfoTxt");
         addChild(_woundTxt);
         _woundTxt.text = "";
      }
      
      public function dispose() : void
      {
         if(_nickNameTxt)
         {
            _nickNameTxt.dispose();
         }
         _nickNameTxt = null;
         if(_woundTxt)
         {
            _woundTxt.dispose();
         }
         _woundTxt = null;
         if(_indexTxt)
         {
            _indexTxt.dispose();
         }
         _indexTxt = null;
         if(_job)
         {
            _job.dispose();
         }
         _job = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

